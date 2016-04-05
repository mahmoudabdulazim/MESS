function [nu] = Calculate_nu0(EccentricityVector,R,V)
        nu=acosd(dot(R,EccentricityVector)/(norm(R)*norm(EccentricityVector)));
        if (dot(R,V) < 0)
            nu = 360 - nu;
        end
end