function [ALPHA, M, S2] =  calc_noise_distribution(grid)

ang_step = 1;
ALPHA = -90:ang_step:90;
M = [];
S2 = [];

tic
for(i=1:numel(ALPHA))
    alpha = ALPHA(i);
    fprintf('Rotation angle: %d\n', alpha);
    %fprintf('--------------------\n');
    C = calcprofcurv(grid.grid, grid.de, alpha);
    [m, s2] = calc_noiselevel(C, grid.de);
    M = [M; m];
    S2 = [S2; s2];
end

fprintf('--------------------\n');
fprintf('Total runtime:\t%5.2f\n', toc);

end
