function offsets = restore_fans(dem, fan_number, data_file)

setfiguredefaults();

radius = 15;
nlines = 50;

m = plotdem(dem); 

[f1, f2, f] = pickline(); % fans 
[s1, s2, s] = pickline(); % scars
[u1, u2, u] = pickline(); % fault trace

fan_endpts = [f1'; f2'];
scar_endpts = [s1'; s2'];
o = [dem.xllcenter; dem.yllcenter];
swaths1 = swathaxis(fan_endpts, dem, radius, nlines); % fan
swaths2 = swathaxis(scar_endpts, dem, radius, nlines); % scars

m = plotdem(dem); 

n = numel(swaths1);
offsets = zeros(n, 1);

for(i=1:n)
    swaths1{i} = projectline(swaths1{i}, u1, u2, o);
    swaths1{i} = smoothprofile(swaths1{i});
    swaths2{i} = projectline(swaths2{i}, u1, u2, o);
    swaths2{i} = smoothprofile(swaths2{i});
    if(fan_number == 3)
        fun1 = @(v) nanmax(v);
        fun2 = @(v) nanmax(v);
        offset = profileoffset(swaths1{i}, swaths2{i}, fun1, fun2);
    else
        offset = profileoffset(swaths1{i}, swaths2{i});
    end
    offsets(i) = offset;
end

print('-depsc2', '-r300', 'map.eps');

k = figure;
plotmany(swaths1, swaths2, offsets, 5);

print('-depsc2', '-r300', 'profs.eps');

k = figure;
subplot(2,1,1)
histdensity(offsets);

print('-depsc2', '-r300', 'hist.eps');

stats = [fan_number, nanmean(offsets), nanmedian(offsets), nanmax(offsets), nanmin(offsets), nanstd(offsets), sum(~isnan(offsets))];
dlmwrite(data_file, stats, 'delimiter', ',', '-append');

fn = strcat('offsets_fan', num2str(fan_number), '.csv');
csvwrite(fn, offsets);

end
