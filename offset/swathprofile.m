function swath = swathprofile(dem, endpts, radius, dx)

%%
%%
%% Modified from code by Sam Johnstone 2015
%%

swath = struct('l', [], 'z', [], 'meanz', [], 'minz', [], 'maxz', [], 'dx', dx);

if(nargin < 4)
    dx = dem.de;
end
if(nargin < 3)
    radius = 10;
end

[lx, ly] = profileline(endpts, dx);
len = [0 cumsum(sqrt((lx(2:end)-lx(1:end-1)).^2 + (ly(2:end)-ly(1:end-1)).^2))];

x = (0:dem.nx-1)*dem.de + dem.xllcenter;
y = (0:dem.ny-1)*dem.de + dem.yllcenter;
[X, Y] = meshgrid(x,y);

idx = profilez(X, Y, lx, ly, radius);

for(i=1:length(idx))
    [~, j] = min(sqrt((X(idx(i))-lx).^2 + (Y(idx(i))-ly).^2));
    swath.z(i) = dem.grid(idx(i));
    swath.l(i) = len(j);
end

len = unique(swath.l);

for(i=1:length(len))
    idx = swath.l == len(i);
    swath.meanz(i) = mean(swath.z(idx));
    swath.minz(i) = min(swath.z(idx));
    swath.maxz(i) = max(swath.z(idx));
end

end
