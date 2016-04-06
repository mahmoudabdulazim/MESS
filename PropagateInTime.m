function [nu] = PropagateInTime(Satellite,t,k)
    switch Satellite.Orbit.Type
        case 'Elliptic'
            M  = Satellite.InitialConditions.M0+Satellite.Orbit.n.*(t-Satellite.InitialConditions.t0);
            Eq =@(x)    M-Satellite.InitialConditions.M0-2*pi()*k+Satellite.InitialConditions.E0-Satellite.Orbit.e.*sin(Satellite.InitialConditions.E0)-x+Satellite.Orbit.e.*sin(x);
            options = optimset('TolX',0.001);
            E  = fzero(Eq,M,options);
            nu = 2*atand(tan(E/2)/sqrt((1-Satellite.Orbit.e)/(1+Satellite.Orbit.e)));
            if nu < 0
               nu = 360 + nu ; 
            end
        case 'Hyperbolic'
            M  = Satellite.InitialConditions.M0+Satellite.Orbit.n.*(t-Satellite.InitialConditions.t0);
            Eq =@(x)    M-Satellite.InitialConditions.M0-Satellite.InitialConditions.E0+Satellite.Orbit.e.*sin(Satellite.InitialConditions.E0)+x-Satellite.Orbit.e.*sin(x);
            options = optimset('TolX',0.001);
            E  = fzero(Eq,M,options);
            nu = 2*atand(tan(E/2)/sqrt((Satellite.Orbit.e-1)/(Satellite.Orbit.e+1)));
        case 'Parabolic'
            M  = Satellite.InitialConditions.M0+Satellite.Orbit.n.*(t-Satellite.InitialConditions.t0);
            Eq =@(x)    M - Satellite.InitialConditions.M0 + Satellite.InitialConditions.E0 + Satellite.InitialConditions.E0^3/3 - x - x^3/3;
            options = optimset('TolX',0.001);
            E  = fzero(Eq,M,options);
            nu = asind(Satellite.Orbit.p*E/norm(Satellite.States.R));
        case 'Circular'
            nu = Satellite.InitialConditions.nu0 + Satellite.Orbit.n * (t-Satellite.InitialConditions.t0);
            if nu > 360
                nu = nu-360;
            end
    end
end