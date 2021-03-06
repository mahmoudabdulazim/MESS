function [] = UpdateOrbitInfo(Satellite,Figure)
    Parameters = [Satellite.Orbit.rp;Satellite.Orbit.ra;Satellite.Orbit.Period;Satellite.Orbit.e; ...
                    Satellite.Orbit.b;Satellite.Orbit.AoP;Satellite.Orbit.a; ...
                    Satellite.Orbit.i;Satellite.Orbit.AoA];
    Letter     = 'PAtebwaiW';
    for k = 1:length(Parameters)
        text = sprintf('%.2f',Parameters(k));
        String = [Letter(k),' = ',text];
        set(Figure(k),'String',String);
    end
end