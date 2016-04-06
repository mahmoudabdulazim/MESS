function [nu] = PropagateInTime(Satellite,t,k)
    
    M  = Satellite.InitialConditions.M0+Satellite.Orbit.n.*(t-Satellite.InitialConditions.t0);
    Eq =@(x)    M-Satellite.InitialConditions.M0-2*pi()*k+Satellite.InitialConditions.E0-Satellite.Orbit.e.*sin(Satellite.InitialConditions.E0)-x+Satellite.Orbit.e.*sin(x);
    options = optimset('TolX',0.001);
    E  = fzero(Eq,M,options);
    nu = 2*atand(tan(E/2)/sqrt((1-Satellite.Orbit.e)/(1+Satellite.Orbit.e)));
    if nu < 0
       nu = 360 + nu ; 
    end
end