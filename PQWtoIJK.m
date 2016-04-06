function [W] = PQWtoIJK(V,AoA,i,AoP)
    
    Rot1 = [cosd(AoA) -sind(AoA) 0; sind(AoA) cosd(AoA) 0; 0 0 1];
    Rot2 = [1 0 0; 0 cosd(i) -sind(i); 0 sind(i) cosd(i)];
    Rot3 = [cosd(AoP) -sind(AoP) 0; sind(AoP) cosd(AoP) 0; 0 0 1];
    
%     Q1   = [cosd(AoA/2) 0         0  sind(AoA/2)];
%     Q2   = [cosd(i/2)   sind(i/2) 0  0          ];
%     Q3   = [cosd(AoP/2) 0         0  sind(AoP/2)];

    W = Rot3*Rot2*Rot1*V;
end