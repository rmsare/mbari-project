function [SNR,A,err] = calcerror_mat_xcurv_renorm(functionname, frac,d,gam,kt,de,DEM,wid, renorm_constant)

%% Computes best-fit wavelet parameters for template scarp
%% George Hilley 2010
%% Minor revisions Robert Sare June 2015
%%
%% INPUT:       frac - limits of scarp profile fit, argument of erfinv
%%              d - out-of-plane dimension of template (m)
%%              gam - strike of template scarp
%%              kt - morphologic age (m^2)
%%              de - dem spacing
%%              DEM - dem grid
%%      
%% OUTPUT:      SNR - grid of signal-to-noise ratio values
%%              A - grid of best-fit amplitudes
%%              err - grid of misfit 

if(nargin < 8)
    wid = 0;
end

nx = length(DEM(1,:));
ny = length(DEM(:,1));

x = [1:nx].*de;y = [1:ny].*de;
x = x - mean(x); y = y - mean(y);

% Compute curvature and create wavelet template
c = calcprofcurv(DEM,de,gam);

if(nargin < 9)
    %TODO: filter curvature
    K = (1/9)*ones(3,3);
    W =  [0 0 0; 0 1 0; 0 0 0] - K;
    cfilt = conv2(W, c);
    renorm_constant = nanstd(cfilt(:));
end
if(wid == 0)
    [W,M,anx,any] = feval(functionname, frac,d,gam,kt,x,y);
else
    [W,M,anx,any] = feval(functionname, frac,d,gam,kt,x,y, wid);
end

i = find(W == 0);
m = ones(size(W));
m(i) = 0;

% FFT and convolve window with curvature grid
fW = fft2(flipud(fliplr(W)));
fc = fft2(c);
sumW2 = sum(W(:).^2);
fc2 = fft2(c.^2);
fm2 = fft2(flipud(fliplr(m.^2)));

% Calculate amplitude
A = fftshift(ifft2((fW./sumW2).*fc));

% Calculate error
i = find(W ~= 0);
n = length(i);
err = (1./n).*((A.^2 .* sumW2) - 2.*A.*fftshift(ifft2(fc.*fW)) + fftshift(ifft2(fc2.*fm2)));
err = err./renorm_constant;

% Typo in paper; SNR should be unit-less
SNR = (A.^2 .* sumW2) ./ err;

% Clip everything outside of window limits
[X,Y] = meshgrid(x,y);
i = find( (X < (min(x)+anx)) | (X > (max(x)-anx)) | (Y < (min(y) + any)) | (Y > (max(y)-any)));
SNR(i) = nan;
%A(i) = nan;

end
