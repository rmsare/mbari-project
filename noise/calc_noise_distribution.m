function [ALPHA, M, S2] =  calc_noise_distribution(grid, half_wid)

ang_step = 1;
ALPHA = 0:ang_step:360;
M = [];
S2 = [];

tic
for(i=1:numel(ALPHA))
    alpha = ALPHA(i);
    %fprintf('Rotation angle: %d\n', alpha);
    %fprintf('--------------------\n');
    C = calcprofcurv(grid.grid, grid.de, alpha);
    [m, s2, zf, Zf] = calc_noiselevel(C, grid.de, half_wid);
    M = [M; m];
    S2 = [S2; s2];
end

%fprintf('--------------------\n');
%fprintf('Total runtime:\t%5.2f\n', toc);

end
