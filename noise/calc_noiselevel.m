function [m, s2, zfilt, Zfilt] = calc_noiselevel(grid, de, half_wid)

if(nargin < 3)
    half_wid = 3;
end
%z = detrend(z);
[ny, nx] = size(grid);
%fs = 1/de;
%fN = 1/(2*de);
%fy = [0:ny-1]*fs/ny;
%fx = [0:nx-1]*fs/nx;
%nymax = ceil(ny/2);
%nxmax = ceil(nx/2);

%tic
Z = fftshift(fft2(grid));
%fprintf('Compute FFT:\t\t%3.2f s\n', toc)

%cy = round(ny/2);
%cx = round(nx/2);
%i = (cy-half_wid:cy+half_wid)';
%j = (cx-half_wid:cx+half_wid)';
%[I, J] = meshgrid(i,j);
%center_ind = sub2ind(size(Z), I(:), J(:));

x = (-floor(nx/2):floor(nx/2)-1);
y = (-floor(ny/2):floor(ny/2)-1);
[X,Y] = meshgrid(x, y);
[TH, R] = cart2pol(X,Y);
center_ind = find(R < half_wid);

Zfilt = Z;
Zfilt(center_ind) = 0;
%fprintf('Apply filter:\t\t%3.2f s\n', toc)

zfilt = ifft2(fftshift(Zfilt));
%fprintf('Compute IFFT:\t\t%3.2f s\n', toc)

m = nanmean(real(zfilt(:)));
s2 = nanstd(real(zfilt(:)));
%fprintf('Calculate statistics:\t%3.2f s\n', toc)

end
