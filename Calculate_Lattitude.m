function [Lattitude] = Calculate_Lattitude(AoP,nu,Longitude)
    Lattitude = asind(sind(Longitude)*sind(AoP+nu));
end