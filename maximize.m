function maximize(hFig)
if nargin < 1
    hFig = gcf;
end
warning('off','MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame');
drawnow % Required to avoid Java errors
jFig = get(handle(hFig), 'JavaFrame'); 
jFig.setMaximized(true);