clc,clear,close all;
Figure = open('MESS.fig');
R0   = [6372;6372.8;0];   V0 = [-4.7028;4.7028;0];
H(1) = Satellite;
H(1).Initialize(R0,V0,0,Figure);
H(2) = Satellite;
H(2).Initialize(-R0,-V0,0,Figure);
h  = Figure.Children(7).Children(2).Children(2);
scatter3(h,0,0,0,500,[0 0 1],'filled')
camproj(h,'perspective')
g = Figure.Children(7).Children(1).Children;
scatter(g,H(1).Longitude,H(1).Latitude)
g.XLim=[-180 180];   g.YLim=[-90 90];
set(h,'XTick',[],'YTick',[],'ZTick',[]);
hold(h,'on')
hold(g,'on')
lamda0 = 0;
k = 1;
for t = 10:100:100000
    for o = 1:length(H)
        H(o).update(t,lamda0);
        H(o).animate(h,g,Figure,k);
        drawnow nocallbacks
%         if (t>=H(o).t0+H(o).Period)
%                        H(o).R = H(o).R(:,end);
%                        H(o).V = H(o).V(:,end);
%         end
        lamda0 = lamda0 + 7.2921159 * 10^-5 * 100*180/pi();
        if lamda0>360
           lamda0 = lamda0 - 360; 
        end
        k = k + 1;
    end
end
hold(h,'off')
hold(g,'off')