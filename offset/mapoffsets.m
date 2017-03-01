function off = mapoffsets(dem)

off = {};
n = 0;

for(i=1:4)
    [fans, scars, off] = restoremany(dem, 15, 15, off, i);
    if(length(off{i}.meas) > n)
        n = length(off{i}.meas);
    end
end

figure(1)
fname = strcat('map.eps')
print(fname, '-depsc2', '-r300', '-FHelvetica:14')
print(fname, '-depsc2', '-r300', '-FHelvetica:14')

figure
hold on

offsets = nan*ones(4,n);
proj_offsets = nan*ones(1,4);
fannum = nan*ones(1,4);

for(i=1:4)
    offsets(off{i}.fannum, 1:length(off{i}.meas)) = off{i}.meas;
    proj_offsets(i) = off{i}.projoffset;
    fannum(i) = off{i}.fannum;
end

boxplot(offsets', 1:4, 'sym', 'r*', 'colors', 'k')

h = findobj(gca,'Tag','Box');
for(j=1:length(h))
    patch(get(h(j), 'XData'), get(h(j), 'YData'), 'y', 'FaceColor', [0.75 0.75 0.75]);
end

boxplot(offsets', fannum, 'sym', 'r*', 'colors', 'k')
plot(fannum, proj_offsets, 'r+', 'markersize', 5)

xlabel('fan number')
ylabel('offset (m)')

fname = 'box.eps')
print(fname, '-depsc2', '-r300', '-FHelvetica:14')

end
