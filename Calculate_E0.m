function [E0] = Calculate_E0(e,nu)
    E0 = acos((e+cosd(nu))./(1+e.*cosd(nu)));
    if nu > 180
        E0 = 360 - E0;
    end
end