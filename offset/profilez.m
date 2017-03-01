function idx = profilez(X, Y, lx, ly, radius)

%%
%% Modified from code by Sam Johnstone 2015
%%

idx = [];

for(i=1:length(lx))
    dist = @(x1, y1, x2, y2) sqrt((x1-x2).^2 + (y1-y2).^2);
    D = dist(lx(i), ly(i), X, Y);
    idx = [idx find(D <= radius)'];
end

end

