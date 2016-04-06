function [] = drawOrbit(Satellite,h)
    R = zeros(3,720);
    for nu = 0:0.5:360
       i = int16(nu*2+1);
       r_PQW  = [Satellite.Orbit.p*cosd(nu)/(1+Satellite.Orbit.e*cosd(nu));Satellite.Orbit.p*sind(nu)/(1+Satellite.Orbit.e*cosd(nu));0];
       R(:,i) = PQWtoIJK(r_PQW,Satellite.Orbit.AoP,Satellite.Orbit.i,Satellite.Orbit.AoA);
    end
    camproj(h,'perspective')
    set(h,'XTick',[],'YTick',[],'ZTick',[]);
    Orbit = animatedline(h,R(1,:),R(2,:),R(3,:));
    drawnow
end