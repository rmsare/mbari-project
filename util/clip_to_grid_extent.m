function [grid1, grid2] = clip_to_grid_extent(grid1, grid2)

if(isnan(grid2.nodata))
    idx = ~isnan(grid2.grid);
else
    idx = grid2.grid ~= grid2.nodata;
end

rows = find(sum(idx, 2) ~= 0);
imax = max(rows);
imin = min(rows);
yshift = (grid2.ny - imax)/grid2.de;

grid1.grid = grid1.grid(imin:imax, :);
grid1.ny = size(grid1.grid, 1);
grid1.yllcenter = grid1.yllcenter + yshift; 
grid2.grid = grid2.grid(imin:imax, :);
grid2.ny = size(grid2.grid, 1);
grid2.yllcenter = grid2.yllcenter + yshift; 

end
