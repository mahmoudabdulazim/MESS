function [AoA,i,AoP,nu] = COE(Type,R,V,E)
    K = [0 0 1];    I=[1 0 0];      H = cross(R,V);       N = cross(K,H);
    
    i = acosd(dot(K,H)/(norm(K)*norm(H)));
    switch Type
        case 'Circular'
            if i == 0
                AoA = 0;
                nu  = Calculate_nu0(E,R,V);
            else
                AoA = Calculate_AoA(N,I);
                nu  = acosd(dot(N,R)/(norm(N)*norm(R)));
                if (R(3) < 0)
                   nu = 360 - nu; 
                end
            end
            AoP = 0;
        otherwise
            if i == 0
               AoP = acosd(E(1)/norm(E));
               if (E(2) < 0)
                  AoP = 360 - AoP; 
               end
               AoA = 0;
            else
               AoP = Calculate_AoP(N,E);
               AoA = Calculate_AoA(N,I);
            end
            nu  = Calculate_nu0(E,R,V);
    end
end