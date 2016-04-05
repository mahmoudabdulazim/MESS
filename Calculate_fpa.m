function [fpa] = Calculate_fpa(R,V,e,nu)
    fpa = acosd((1+e*cosd(nu))/(sqrt(1+2*e*cosd(nu)+e^2)));
    if (dot(R,V)<0)
        fpa = -fpa;
    end
end