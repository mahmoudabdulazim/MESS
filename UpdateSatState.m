function []=UpdateSatState(Satellite,h)
    States = [Satellite.nu(end);Satellite.Latitude(end);Satellite.Longitude(end);norm(Satellite.R(:,end))-6387;norm(Satellite.V(:,end))];
    Letter = 'YnFlLV';
    for k = 2:length(States)+1
        text = sprintf('%.1f',States(k-1));
        String = [Letter(k),' = ', text];
        set(h(k),'String',String);
    end
end