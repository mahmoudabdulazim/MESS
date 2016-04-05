%% Class definition of a Satellite object
classdef Satellite < handle
   properties
       Orbit             = struct('i',[],'AoA',[], 'AoP',[],   'e',    [],    'a',    [],    'b',    [],    'h',    [],'Type',[],'Energy',[],'Period',[],'p',[]);
       States            = struct('R',[],'V',  [], 'nu', [],'Altitude',[],'Longitude',[],'Lattitude',[],    't' ,   []);
       InitialConditions = struct('R',[],'V',  [], 't0', [],'nu',[],   'MA'   ,[],   'EA',   []);
       e=[];    nu=[];  fpa=[]; t0 = [];    E0=[]; M0=[]; p=[]; n=[]; nu0=[];
       R=[];    V=[];   Latitude = [];  Longitude = []; R0=[];  rp = [];    ra=[];
   end
   
   methods
       function [Satellite] = Initialize(Satellite,R0,V0,t0)
           %% Calculation of Characteristic Orbit Parameters
           Satellite.t0 = t0;               r0 = norm(R0);      
           H = cross(R0,V0);                v0  = norm(V0);               
           E = mu^-1 * ((v0^2-mu/r0)*R0-dot(R0,V0)*V0);
           
           Satellite.Orbit.h = norm(H);                                     Satellite.Orbit.Energy = v0^2/2 - mu/r0;                             
           Satellite.Orbit.e = norm(E);
           
           %% Orbit Type Determination
           if (Satellite.Orbit.e ~= 1)
               Satellite.Orbit.a        = -mu/(2*Energy);
               Satellite.Orbit.p        = Satellite.Orbit.h^2./mu;
               if Satellite.Orbit.e > 1
                  Satellite.Orbit.Type = 'Hyperbolic';
                  Satellite.Orbit.b    = NaN;
               else
                   Satellite.Orbit.b   = Satellite.Orbit.a*sqrt(1-Satellite.Orbit.e^2);
                   if Satellite.Orbit.e > 0
                       Satellite.Orbit.Type = 'Elliptic';
                   else
                       Satellite.Orbit.Type = 'Circular';                       
                   end
               end
           else
               Satellite.Orbit.a        = Inf;
               Satellite.Orbit.b        = Inf;
               Satellite.Orbit.p        = Satellite.Orbit.h^2/mu;
               Satellite.Orbit.Type     = 'Parabolic';
           end
           %%   Calculation of Classical Orbital Elements
           [AoA,i,AoP]                      = COE(Satellite.Obit.Type,R0,V0,E);
           Satellite.InitialConditions.nu0  = Calculate_nu0(E,R0,V0);
           Satellite.InitialConditions.E0   = Calculate_E0(Satellite.Orbit.e,Satellite.States.nu0);
           Satellite.InitialConditions.M0   = Calculate_M0(Satellite.InitialConditions.E0,Satellite.Orbit.e);
           Satellite.InitialConditions.R    = R0;
           Satellite.InitialConditions.V    = V0;
           Satellite.Orbit.AoA              = AoA;
           Satellite.Orbit.AoP              = AoP;
           Satellite.Orbit.i                = i;
           Satellite.Orbit.n                = sqrt(mu./Satellite.Orbit.a.^3);
           Satellite.Orbit.rp               = Satellite.Orbit.p/(1+Satellite.Orbit.e);
           Satellite.Orbit.ra               = Satellite.Orbit.p/(1-Satellite.Orbit.e);
           Satellite.Orbit.Period           = 2*pi()/Satellite.n;
       end
       
       function [Satellite] = update(Satellite,T,lamda0)
           if (T > Satellite.t0)
               Satellite.States.nu = PropagateInTime(Satellite,T,0);
               r_PQW               = [Satellite.Orbit.p*cosd(Satellite.States.nu)/(1+Satellite.Orbit.e*cosd(Satellite.States.nu));Satellite.Orbit.p*sind(Satellite.States.nu)/(1+Satellite.Orbit.e*cosd(Satellite.States.nu));0];
               v_PQW               = [-sqrt(mu./Satellite.Orbit.p).*sind(Satellite.States.nu); sqrt(mu./Satellite.Orbit.p).*(Satellite.Orbit.e + cosd(Satellite.States.nu));0];
               Satellite.States.R  = PQWtoIJK(r_PQW,Satellite.Orbit.AoP,Satellite.Orbit.i,Satellite.Orbit.AoA);
               Satellite.States.V  = PQWtoIJK(v_PQW,Satellite.Orbit.AoP,Satellite.Orbit.i,Satellite.Orbit.AoA);
               Satellite.Latitude  = Calculate_Lattitude(Satellite.Orbit.AoP,Satellite.States.nu,Satellite.Orbit.i);
               Satellite.Longitude = Calculate_Longitude(Satellite.States.R,Satellite.States.Latitude,lamda0);
           end
       end
       
       function [Satellite] = animate(Satellite,O,G,Figure,k)
           scatter3(O,Satellite.States.R(1),Satellite.States.R(2),Satellite.States.R(3),20,[1 0 0],'filled');
           scatter (G,Satellite.Longitude,Satellite.Latitude)
           if rem(k,10)==0
                UpdateSatState(Satellite,Figure.Children(7).Children(2).Children(1).Children)
           end
       end
   end
end

%Auxilary functions to aid in computations

function [nu] = PropagateInTime(Satellite,t,k)
    M  = Satellite.InitialConditions.M0+Satellite.Orbit.n.*(t-Satellite.InitialConditions.t0);
    Eq =@(x)    M-Satellite.InitialConditions.M0-2*pi()*k+Satellite.InitialConditions.E0-Satellite.Orbit.e.*sin(Satellite.InitialConditions.E0)-x+Satellite.Orbit.e.*sin(x);
    options = optimset('TolX',0.0001);
    E  = fzero(Eq,M,options);
    nu = 2*atan2d(tan(E/2),sqrt((1-Satellite.Orbit.e)/(1+Satellite.Orbit.e)));
    if nu <0
       nu = 360 - abs(nu); 
    end
end

function [W] = PQWtoIJK(V,AoA,i,AoP)
    
    Rot1 = [cosd(AoA) -sind(AoA) 0; sind(AoA) cosd(AoA) 0; 0 0 1];
    Rot2 = [1 0 0; 0 cosd(i) -sind(i); 0 sind(i) cosd(i)];
    Rot3 = [cosd(AoP) -sind(AoP) 0; sind(AoP) cosd(AoP) 0; 0 0 1];
    
%     Q1   = [cosd(AoA/2) 0         0  sind(AoA/2)];
%     Q2   = [cosd(i/2)   sind(i/2) 0  0          ];
%     Q3   = [cosd(AoP/2) 0         0  sind(AoP/2)];

    W = Rot3*Rot2*Rot1*V;
end

function [E0] = Calculate_E0(e,nu)
    E0 = acos((e+cosd(nu))./(1+e.*cosd(nu)));
    if nu > 180
        E0 = 360 - E0;
    end
end

function [M0] = Calculate_M0(E0,e)
    M0 = E0 - e*sin(E0);
end