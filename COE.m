function [AoA,i,AoP] = COE(Type,R,V,E)
    K = [0 0 1];    I=[1 0 0];      H = cross(R,V);       N = cross(K,H);
    
    i = acosd(dot(K,H)/(norm(K)*norm(H)));
    switch Type
        case 'Circular'
            if i == 0
                AoA = 0;
            else
                AoA = Calculate_AoA(N,I);
            end
            AoP = 0;
        otherwise
            if i == 0
               AoP = acosd(E(1)/norm(E));
               AoA = 0;
            else
               AoP = Calculate_AoP(N,E);
               AoA = Calculate_AoA(N,I);
            end            
    end
end