function [AoA] = Calculate_AoA(N,I)
    AoA = acosd(dot(I,N)/(norm(I)*norm(N)));
    if (N(2) < 0)
       AoA = 360 - AoA; 
    end
end