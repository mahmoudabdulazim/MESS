function [AoP] = Calculate_AoP(N,E)
    AoP = acosd(dot(E,N)/(norm(E)*norm(N)));
    if (E(3) < 0)
       AoP = 360 - AoP;
    end
end
