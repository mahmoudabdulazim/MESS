function []=UpdateSatState(Satellite,h)
    States = [Satellite.States.nu;Satellite.States.Lattitude;Satellite.States.Longitude;norm(Satellite.States.R)-6387;norm(Satellite.States.V)];
    Letter = 'YnFlLV';
    for k = 2:length(States)+1
        text = sprintf('%.1f',States(k-1));
        String = [Letter(k),' = ', text];
        set(h(k),'String',String);
    end
end