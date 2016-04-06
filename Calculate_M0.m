function [M0] = Calculate_M0(E0,e)
    M0 = E0 - e*sin(E0);
end
