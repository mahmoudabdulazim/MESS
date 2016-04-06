function [Lattitude] = Calculate_Lattitude(AoP,nu,i)
    Lattitude = asind(sind(i)*sind(AoP+nu));
end