function calculate_params_angle_constraint(dem_dir, angle_dir, output_dir, d)

if(nargin < 4)
    d = 100;
end
if(nargin < 3)
    output_dir = './';
end

if(~strcmp(dem_dir(end), '/'))
    dem_dir = strcat(dem_dir, '/');
end
if(~strcmp(angle_dir(end), '/'))
    angle_dir = strcat(angle_dir, '/');
end
if(~strcmp(output_dir(end), '/'))
    output_dir = strcat(output_dir, '/');
end

dem_files = dir(strcat(dem_dir, '*1m.asc'));
angle_files = dir(strcat(angle_dir, '*.asc'));
nfiles = numel(dem_files);

for(i=1:nfiles)
    dem_fn = strcat(dem_dir, dem_files(i).name);
    grid_name = dem_files(i).name(1:6);

    angle_fn = '';
    k = 0;
    for(j=1:numel(angle_files))
        angle_fn = angle_files(j).name;
        if(numel(strfind(angle_fn, grid_name)) > 0)
            k = j;
        end
    end

    if(k>0)
        angle_fn = strcat(angle_dir, angle_files(k).name);
        fprintf(strcat(dem_fn,'\n'))
        fprintf(strcat(angle_fn,'\n'))
        
        dem = dem2mat(dem_fn);
        dem.grid(dem.grid <= -9999) = dem.nodata;

        angle = dem2mat(angle_fn);
        angle.grid(angle.grid <= -9999) = angle.nodata;

        [dem, angle] = clip_to_grid_extent(dem, angle);
        [dem, nanidx] = noisedem(dem);
        num_nans = sum(isnan(dem.grid(:)));
        while(num_nans > 0)
            dem = noisedem(dem);
            num_nans = sum(isnan(dem.grid(:)));
        end
        
        label = strcat(grid_name, '_noised_clipped_');
        saverun(dem, nanidx, d, angle, output_dir, label);
        mat2dem(angle, strcat(angle_fn(1:end-4), '_clipped.asc'));
        mat2dem(dem, strcat(dem_fn(1:end-4), '_clipped.asc'));
    else
        fprintf(strcat(['No feature orientations matching ', dem_fn, ' \n']));
    end

end
