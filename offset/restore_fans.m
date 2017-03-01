function offsets = restore_fans(dem)

swaths1 = pickprofiles(dem, 15); % fan
swaths2 = pickprofiles(dem, 15); % scar


n = numel(swaths1);
offsets = zeros(n, 1);

for(i=1:n)
    offset = profileoffset(swaths1{i}, swaths2{i});
    offsets(i) = offsets;
end

end
