%% Class definition of a Satellite object
classdef Satellite < handle
   %% Start of Properties Definitions:
   properties
       Name              = [];
       Orbit             = struct('i',[],'AoA',[], 'AoP',[],   'e',    [],    'a',    [],    'b',    [],    'h',    [],'Type',[],'Energy',[],'Period',[],'p',[],'ra',[],'rp',[]);
       States            = struct('R',[],'V',  [], 'nu', [],'Altitude',[],'Longitude',[],'Lattitude',[],    't',    [],'Fpa' ,[]);
       InitialConditions = struct('R',[],'V',  [], 't0', [],'nu0',[],   'M0'   ,[],   'E0',   []);
   end
   %% Ending of Properties Definitions.
   %% Start of Method Defnitions:
   methods
       function [Satellite] = RVCOE(Satellite,R0,V0,t0,Name)
           Satellite.Name = Name;
           %% Calculation of Characteristic Orbit Parameters
           Satellite.InitialConditions.t0 = t0;               r0 = norm(R0);      
           H = cross(R0,V0);                v0  = norm(V0);               
           E = mu^-1 * ((v0^2-mu/r0)*R0-dot(R0,V0)*V0);
           
           Satellite.Orbit.h = norm(H);                                     Satellite.Orbit.Energy = v0^2/2 - mu/r0;                             
           Satellite.Orbit.e = norm(E);
           
           %% Orbit Type Determination
           Satellite.Categorize();
           %%   Calculation of Classical Orbital Elements
           Satellite.InitialConditions.R    = R0;
           Satellite.InitialConditions.V    = V0;
           [AoA,i,AoP,nu]                   = COE(Satellite.Orbit.Type,R0,V0,E);
           Satellite.Orbit.AoA              = AoA;
           Satellite.Orbit.AoP              = AoP;
           Satellite.Orbit.i                = i;
           Satellite.InitialConditions.nu0  = nu;
           Satellite.InitialConditions.E0   = Calculate_E0(Satellite.Orbit.e,Satellite.InitialConditions.nu0);
           Satellite.InitialConditions.M0   = Calculate_M0(Satellite.InitialConditions.E0,Satellite.Orbit.e);
           Satellite.States.nu              = nu;
           Satellite.States.M               = Satellite.InitialConditions.M0;
           Satellite.States.E               = Satellite.InitialConditions.E0;
           Satellite.Characterize();
           Satellite.update(t0,0);
       end
       
       function [Satellite] = Characterize(Satellite)
           switch Satellite.Orbit.Type
               
               case 'Elliptic'
                   Satellite.Orbit.n                = sqrt(mu./Satellite.Orbit.a.^3);
                   Satellite.Orbit.rp               = Satellite.Orbit.p/(1+Satellite.Orbit.e);
                   Satellite.Orbit.ra               = Satellite.Orbit.p/(1-Satellite.Orbit.e);
                   Satellite.Orbit.Period           = 2*pi()/Satellite.Orbit.n;
               case 'Circular'
                   Satellite.Orbit.n                = sqrt(mu./Satellite.Orbit.a.^3);
                   Satellite.Orbit.rp               = NaN;
                   Satellite.Orbit.ra               = NaN;
                   Satellite.Orbit.Period           = 2*pi()/Satellite.Orbit.n;
               case 'Hyperbolic'
                   Satellite.Orbit.n                = sqrt(mu./-Satellite.Orbit.a.^3);
                   Satellite.Orbit.rp               = Satellite.Orbit.p/(1+Satellite.Orbit.e);
                   Satellite.Orbit.ra               = Inf;
                   Satellite.Orbit.Period           = Inf;
               case 'Parabolic'
                   Satellite.Orbit.n                = 2 * sqrt(mu./Satellite.Orbit.p.^3);
                   Satellite.Orbit.rp               = Satellite.Orbit.p/2;
                   Satellite.Orbit.ra               = Inf;
                   Satellite.Orbit.Period           = Inf;
           end
       end
       
       function [Satellite] = Categorize(Satellite)
           
           if (Satellite.Orbit.e ~= 1)
               Satellite.Orbit.a        = -mu/(2*Satellite.Orbit.Energy);
               Satellite.Orbit.p        = Satellite.Orbit.h^2./mu;
               if Satellite.Orbit.e > 1
                  Satellite.Orbit.Type = 'Hyperbolic';
                  Satellite.Orbit.b    = Satellite.Orbit.a*sqrt(Satellite.Orbit.e^2 - 1);
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
       end
       
       function [Satellite] = update(Satellite,T,lamda0)
           if (T >= Satellite.InitialConditions.t0)
               Satellite.States.nu         = PropagateInTime(Satellite,T,0);
               r_PQW                       = [Satellite.Orbit.p*cosd(Satellite.States.nu)/(1+Satellite.Orbit.e*cosd(Satellite.States.nu));Satellite.Orbit.p*sind(Satellite.States.nu)/(1+Satellite.Orbit.e*cosd(Satellite.States.nu));0];
               v_PQW                       = [-sqrt(mu./Satellite.Orbit.p).*sind(Satellite.States.nu); sqrt(mu./Satellite.Orbit.p).*(Satellite.Orbit.e + cosd(Satellite.States.nu));0];
               Satellite.States.R          = PQWtoIJK(r_PQW,Satellite.Orbit.AoP,Satellite.Orbit.i,Satellite.Orbit.AoA);
               Satellite.States.V          = PQWtoIJK(v_PQW,Satellite.Orbit.AoP,Satellite.Orbit.i,Satellite.Orbit.AoA);
               Satellite.States.Lattitude  = Calculate_Lattitude(Satellite.Orbit.AoP,Satellite.States.nu,Satellite.Orbit.i);
               Satellite.States.Longitude  = Calculate_Longitude(Satellite.States.R,Satellite.States.Lattitude,lamda0);
           end
       end
       
       function [Satellite] = animate(Satellite,O,G,Figure,k)
           addpoints(O,Satellite.States.R(1),Satellite.States.R(2),Satellite.States.R(3));
           addpoints(G,Satellite.States.Longitude,Satellite.States.Lattitude)
           drawnow nocallbacks
           if rem(k,10)==0
                UpdateSatState(Satellite,Figure.Children(7).Children(2).Children(1).Children)
           end
       end
       
   end
   %% End of Method definitions
end
%% End of Class Definiton