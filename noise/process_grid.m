function [ALPHA, M, S2] = process_grid(dem, th_rot, radius)

[ALPHA, M, S2] = calc_noise_distribution(dem, radius);

ALPHA = ALPHA' + (180/pi)*th_rot;

alpha_max = ALPHA(S2 == nanmax(S2))
m_max = M(S2 == nanmax(S2));
s2_max = S2(S2 == nanmax(S2));

figure
plotrose(ALPHA, S2, 'ro', [1 0 0])
figure
plotrose(ALPHA, abs(M), 'ko', [0 0 0])

alpha_max = min(ALPHA(S2 == max(S2)));
Cmax = calcprofcurv(dem.grid, dem.de, alpha_max-(180/pi)*th_rot);
[m, s2, zf, Zf] = calc_noiselevel(Cmax, dem.de, radius);

figure
subplot(1,2,1)
hold on
box on
imagesc(Cmax)
caxis([-0.5 0.5])
colorbar
axis xy; axis image;

subplot(1,2,2)
hold on
[x, y] = meshgrid(1:dem.nx, 1:dem.ny);
xc = dem.nx/2+1;
dfx = 1/(dem.nx*dem.de);
fx = dfx*(x-xc);
yc = dem.ny/2+1;
dfy = 1/(dem.ny*dem.de);
fy = dfy*(y-yc);
imagesc(fx(1,:)', fy(:,1), abs(Zf))
axis image
colorbar
box on
xlabel('x frequency (m^{-1})')
ylabel('y frequency (m^{-1})')

figure
subplot(2,1,1)
hold on
box on
plot(Cmax(1000,:), 'ko', 'MarkerSize', 2, 'MarkerFaceColor', [0 0 0])
xlabel('x (m)')
ylabel('profile curvature (m^{-1})')
xlim([0 dem.nx])

subplot(2,1,2)
hold on
box on
plot(Cmax(:,1000), 'ko', 'MarkerSize', 2, 'MarkerFaceColor', [0 0 0])
xlabel('y (m)')
ylabel('profile curvature (m^{-1})')
xlim([0 dem.ny])

m_max
s2_max
end
