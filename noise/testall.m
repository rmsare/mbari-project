function testall(dem_dir)

files = dir(strcat(dem_dir, '*1m.asc'));
for(i=1:numel(files))
    fprintf(strcat(files(i).name, '\n'))
    tic
    dem = dem2mat(strcat(dem_dir, files(i).name));
    fprintf('Load DEM:\t\t%3.2f s\n', toc)
    [dem, th] = rotatedem(dem);
    fprintf('Rotate DEM:\t\t%3.2f s\n', toc)
    dem = clipdem(dem);
    fprintf('Clip DEM:\t\t%3.2f s\n', toc)
    dem = noisedem(dem);
    fprintf('Noise DEM:\t\t%3.2f s\n', toc)

    titlestr = strcat(files(i).name);
    figure
    ploths(dem);
    title(titlestr);
    
    test_noise_distribution(dem, th);
    fprintf('Estimate noise:\t\t%3.2f s\n', toc)
end

fprintf('Total runtime:\t\t%3.2f s\n', toc)
fprintf('--------------------\n');

end 
