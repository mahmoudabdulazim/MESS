function [E0] = Calculate_E0(e,nu)
    if e == 1
        E0 = tand(nu/2);
    elseif e < 1
        E0 = acos((e+cosd(nu))./(1+e.*cosd(nu)));
        if nu > 180
            E0 = 360 - E0;
        end 
    elseif e > 1
        E0 = 2*atanh(sqrt((e-1)/(e+1))*tand(nu/2));
    else
        E0 = NaN;
    end
end