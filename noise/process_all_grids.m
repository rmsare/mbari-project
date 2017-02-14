function process_grid(dem_filename, radius)

dem = dem2mat(dem_filename);
[dem, th] = rotatedem(dem);
dem = clipdem(dem);

[dem.ny dem.nx] = size(dem.grid);

num_nodata = sum(isnan(dem.grid(:)));
while(num_nodata > 0)
    dem = noisedem(dem);
    num_nodata = sum(isnan(dem.grid(:)));
end

[ALPHA, M, S2] = calc_noise_distribution(dem.grid, dem.de, radius);

ALPHA = ALPHA + (180/pi)*th_rot;
TH = ALPHA'.*(pi/180);

figure
U = M.*cos(TH);
V = M.*sin(TH);
compass(U, V, 'k-o')

figure
U = S2.*cos(TH);
V = S2.*sin(TH);
compass(U, V, 'r-o')


alpha_max = ALPHA(S2 == nanmax(S2));
m_max = S2(S2 == nanmax(S2));
s2_max = S2(S2 == nanmax(S2));


end
