function [Longitude] = Calculate_Longitude(R,phi,lamda0,k)
    r = norm(R);
    Sigma = acosd(R(1)/(r*cosd(phi)));
    if R(2) < 0
        Sigma = 360 - Sigma;
    end
    Longitude = Sigma - lamda0;
end