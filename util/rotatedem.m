function [rotated, theta] = rotatedem(dem, theta)

if(nargin < 2)
    rowsums = sum(~isnan(dem.grid), 2);
    colsums = sum(~isnan(dem.grid), 1);

    minrows = find(rowsums == min(rowsums(rowsums > 0)));
    mincols = find(colsums == min(colsums(colsums > 0)));

    testrow = dem.grid(min(minrows), :);
    testcol = max(find(~isnan(testrow)));

    u1 = [testcol; min(minrows)];

    testcol = dem.grid(:, max(mincols));
    testrow = min(find(~isnan(testcol)));

    u2 = [max(mincols); testrow];

    u = u2 - u1;

    if(u(1) < 0)
        u = -u;
    end

    v = [1; 0];
    theta = acos(dot(u, v)./(norm(v)*norm(u)));
end

[m, n] = size(dem.grid);
x = 1:n;
y = 1:m;
[X, Y] = meshgrid(x, y);

Xrot = X.*cos(theta) - Y.*sin(theta);
Yrot = X.*sin(theta) + Y.*cos(theta);

if(min(Xrot(:)) < 0)
    Xrot = Xrot + abs(min(Xrot(:)));
end
if(min(Yrot(:)) < 0)
    Yrot = Yrot + abs(min(Yrot(:)));
end

xq = 1:dem.de:max(Xrot(:));
yq = 1:dem.de:max(Yrot(:));
[Xq, Yq] = meshgrid(xq, yq);

rotated = dem;
rotated.grid = griddata(Xrot(:), Yrot(:), double(dem.grid(:)), Xq, Yq);
rotated.xllcenter = 0;
rotated.yllcenter = 0;
[rotated.ny, rotated.nx] = size(rotated.grid);
rotated = computeslopeaz(rotated);

end
