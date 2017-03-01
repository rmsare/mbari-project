function [lx, ly] = profileline(endpts, dx)

%%
%%
%% Modified from code by Sam Johnstone 2015
%%

lx = [];
ly = [];

for(i=1:length(endpts)-1)
    y = endpts(i+1,2) - endpts(i,2);
    x = endpts(i+1,1) - endpts(i,1);
    th = atan2(y, x);
    dist = norm([x y], 2);
    l = linspace(dx, dist, round(dist./dx));

    lx = [lx [endpts(i,1) endpts(i,1) + l*cos(th)]];
    ly = [ly [endpts(i,2) endpts(i,2) + l*sin(th)]];
end

end

