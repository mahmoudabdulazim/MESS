clc,clear,close all;
Figure = open('MESS.fig');
T  = datetime;
JD = juliandate(T);
R0   = [2615;15881;3980];   V0 = [-2.767;-0.7905;4.980];
H(1) = Satellite;
H(1).Initialize(R0,V0,0);
H(2) = Satellite;
H(2).Initialize(-R0,-V0,0);
h  = Figure.Children(7).Children(2).Children(2);
scatter3(h,0,0,0,500,[0 0 1],'filled')
camproj(h,'perspective')
g = Figure.Children(7).Children(1).Children;
scatter(g,H(1).States.Longitude,H(1).States.Lattitude)
g.XLim=[0 360];   g.YLim=[-90 90];
set(h,'XTick',[],'YTick',[],'ZTick',[]);
Trajectory  = animatedline(h,'Color','r','LineWidth',0.5,'Marker','o','MarkerSize',1);
GroundTrack = animatedline(g,'Color','r','LineWidth',0.5,'Marker','o','MarkerSize',1);
% hold(h,'on')
% hold(g,'on')
lamda0 = 0;
k = 1;
for t = 0:60:100000
    for o = 1:1 %length(H)
        H(o).update(t,lamda0);
        H(o).animate(Trajectory,GroundTrack,Figure,k);
%         if (t>=H(o).t0+H(o).Period)
%                        H(o).R = H(o).R(:,end);
%                        H(o).V = H(o).V(:,end);
%         end
        lamda0 = lamda0 + 7.2921159 * 10^-5 * 10*180/pi();
%         if lamda0>360
%            lamda0 = lamda0 - 360; 
%         end
        k = k + 1;
    end
end