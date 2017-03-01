function smooth = smoothprofile(swath, width, kernel)


if(nargin < 2)
    width = 5*swath.dx;
end

n = round(width/swath.dx);

if(nargin < 3)
    kern = ones(1,n)./n; 
else

    kern = kernel(width);
end

smooth = swath;
mmz = nanmean(swath.meanz);
%smooth.meanz = conv(swath.meanz - mmz, kern) + mmz;
smooth.meanz = filtfilt(kern, 1, swath.meanz - mmz) + mmz;
mmax = nanmean(swath.maxz);
smooth.maxz = filtfilt(kern, 1, swath.maxz - mmax) + mmax;
mmin = nanmean(swath.minz);
smooth.minz = filtfilt(kern, 1, swath.minz - mmin) + mmin;

end
