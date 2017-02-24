%% Given R0 and V0 expressed in 3D coordinates, Orbital Parameters are to be determined
clc,clear
mu = 3.986*10^5;
R = input('Please enter the Position vector in the form: [X Y Z]');
V = input('Please enter the Velocity vector in the form: [X Y Z]');
if (any(size(R)~=[1 3])|| any(size(V)~=[1 3]))
    error('Please adhere to the appropriate form of input mentioned in the input prompt statement')
end
r  = sqrt(R*R');    v  = sqrt(V*V');
%% Vector quantities are calculated and used for determining orbital attitude
H = cross(R,V);     K = [0 0 1];    I=[1 0 0];       N = cross(K,H);      Ecc=1/mu *((v^2-mu/r)*R-dot(R,V)*V);
inc = acosd(dot(K,H)/(norm(K)*norm(H)));   OMG = acosd(dot(I,N)/(norm(I)*norm(N)));       omg=acosd(dot(R,Ecc)/(norm(R)*norm(Ecc)));    nuu=acosd(dot(R,Ecc)/(norm(R)*norm(Ecc)));
%% Direct application of formulas derived from a simplified two-body problem is then used to calculate orbital shape parameters
E  = v^2/2 - mu/r;          h  = r*v;
a  = -mu/(2*E);     e  = sqrt(1+2*E*h^2/mu^2);    b  = a*sqrt(1-e^2);
rp = (1-e)*a;       ra = 2*a-rp;                p = h^2/mu; %% semi-latus rectum
%% Simulation of spacecraft motion is carried out for variation of true anomaly from 0 to 360 degrees
r_i= zeros(size(0:0.1:360));
v_i= zeros(size(0:0.1:360));
phi= zeros(size(0:0.1:360));
r_v= zeros(size(0:0.1:360,1),2);
ROT1=[cosd(omg) -sind(omg) 0;sind(omg) cosd(omg) 0;0 0 1];
ROT2=[1 0 0; 0 cosd(inc) -sind(inc);0 sind(inc) cosd(inc)];
ROT3=[cosd(OMG) -sind(OMG) 0;sind(OMG) cosd(OMG) 0; 0 0 1];
ROT = ROT1*ROT2*ROT3;
figure, scatter3(0,0,0,500,[0 0 1],'filled'),hold on
for nu = 0:0.1:360
    tu=nu/3;
    c=int32(nu/0.1+1);
    r_i(c)=p/(1+e*cosd(nu));
    v_i(c)=sqrt(2*mu/r_i(c) - mu/a);
    phi(c)=(1+e*cosd(nu))/(sqrt(1+2*e*cosd(nu)+e^2));
    r_pqw(c,:) = [p*cosd(nu)/(1+e*cosd(nu)) p*sind(nu)/(1+e*cosd(nu)) 0];
    r_ijk(c,:) = (ROT*r_pqw(c,:)')';
    v_pqw(c,:) = [-sqrt(mu/p)*sind(nu) sqrt(mu/p)*(e+cosd(nu)) 0];
    v_ijk(c,:) = (ROT*v_pqw(c,:)')';
    ROT_3=[cosd(tu) -sind(tu) 0;sind(tu) cosd(tu) 0; 0 0 1];
    r_ecef(c,:) = (ROT_3*r_ijk(c,:)')';
    dot(r_ecef(c,:),[1 0 0])
end
scatter3(r_ijk(:,1),r_ijk(:,2),r_ijk(:,3),3,[0 1 0],'filled')
for c =1:3601
    scatter3(r_ijk(c,1),r_ijk(c,2),r_ijk(c,3),20,[1 0 0],'filled')
    axis manual tight ,axis([-ra ra -ra ra -ra ra])
    pause(0.001) 
end
hold off
