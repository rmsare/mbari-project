function [m, s2] = calc_noiselevel(grid, de)

%z = detrend(z);
[ny, nx] = size(grid);
%fs = 1/de;
%fN = 1/(2*de);
%fy = [0:ny-1]*fs/ny;
%fx = [0:nx-1]*fs/nx;
%nymax = ceil(ny/2);
%nxmax = ceil(nx/2);

%tic
Z = fft2(grid);
A = abs(Z);
%fprintf('Compute FFT:\t\t%3.2f s\n', toc)

cy = round(ny/2);
cx = round(nx/2);
i = (cy-100:cy+100)';
j = (cx-100:cx+100)';
[I, J] = meshgrid(i,j);
center_ind = sub2ind(size(Z), I(:), J(:));
Zfilt = Z;
Zfilt(center_ind) = 0;

%fprintf('Apply filter:\t\t%3.2f s\n', toc)

zfilt = fftshift(ifft2(Zfilt));
%fprintf('Compute IFFT:\t\t%3.2f s\n', toc)

m = nanmean(zfilt(:));
s2 = nanstd(zfilt(:));
%fprintf('Calculate statistics:\t%3.2f s\n', toc)

end
