function [A, KT, ANG, SNR] = wavelet_filtertile_angular_constraint(dem, d, logkt_max, kt_step, anggrid, nanidx)

%% 
%%
%% Applies wavelet filter to DEM, returning best-fit parameters at each grid
%% point using grid search over equal-angle template orientation intervals 
%%
%% Robert Sare January 2016
%% Based on 2010 implementation by George Hilley
%%
%% INPUT:       dem - dem grid struct
%%              d - length of template scarp in out-of-plane direction
%%              logkt_max - maximum log10(kt)
%%              ang_step - stepsize for equiangular search
%%
%% OUTPUT:      bestA - best-fit scarp amplitudes
%%              bestKT - best-fit morphologic ages
%%              bestANG - best-fit strikes
%%              bestSNR - signal-to-noise ration for best-fit A and error

% Scarp-face fraction, noise level, template length 
frac = 0.9;

% search over fixed orientation and ages
LOGKT = 0:kt_step:logkt_max;

de = dem.de;
M = dem.grid;
bestSNR = zeros(size(M));
bestA = zeros(size(M));
bestKT = zeros(size(M));
bestANG = -9999*ones(size(M));

A = dem;
KT = dem;
ANG = dem;
SNR = dem;

A.grid = nan*ones(size(dem.grid));
KT.grid = nan*ones(size(dem.grid));
ANG.grid = nan*ones(size(dem.grid));
SNR.grid = nan*ones(size(dem.grid));

% Grid search
grididxs = find(~isnan(anggrid.grid));
angles = round(anggrid.grid(grididxs));

ALPHA = [];
for(i=1:numel(angles))
    ALPHA = [ALPHA angles(i)-1:angles(i)+1];
end
ALPHA = unique(ALPHA);

% Search over full range of morphologic ages 
for(i=1:length(ALPHA))
    thisalpha = ALPHA(i);
    for(j=1:length(LOGKT))
        thiskt = 10.^LOGKT(j);
        
        % Compute wavelet parameters for this orientation and morphologic age
        [thisSNR,thisA,thiserr] = calcerror_mat_xcurv(frac,d,thisalpha,thiskt,de,M);
        k = find(isnan(thisSNR));
        thisSNR(k) = 0;
        thisSNR(nanidx) = 0;
        
        % Retain parameters with maximum SNR 
        bestA = (bestSNR < thisSNR).*thisA + (bestSNR >= thisSNR).*bestA;
        bestKT = (bestSNR < thisSNR).*thiskt + (bestSNR >= thisSNR).*bestKT;
        bestANG = (bestSNR < thisSNR).*thisalpha + (bestSNR >= thisSNR).*bestANG;
        bestSNR = (bestSNR < thisSNR).*thisSNR + (bestSNR >= thisSNR).*bestSNR;
    end
    
    angle_idx = find(round(anggrid.grid) == thisalpha);
    A.grid(angle_idx) = bestA(angle_idx);
    KT.grid(angle_idx) = bestKT(angle_idx);
    ANG.grid(angle_idx) = bestANG(angle_idx);
    SNR.grid(angle_idx) = bestSNR(angle_idx);
    
    fprintf('%6.2f%%\n',((i*length(LOGKT))./(prod([length(ALPHA),length(LOGKT)])))*100);
end

A.grid(nanidx) = nan; 
KT.grid(nanidx) = nan;
ANG.grid(nanidx) = nan;
SNR.grid(nanidx) = nan;
    
end
