function saverun(dem, nanidx, d, anggrid, working_dir, label)

[A, KT, ANG, SNR] = wavelet_filtertile_angular_constraint(dem, d, 3.5, 0.1, anggrid, 1, nanidx);

dem.grid(nanidx) = dem.nodata;
A.grid(nanidx) = nan;
KT.grid(nanidx) = nan;
SNR.grid(nanidx) = nan;

idx = nanidx;

logkt_max = 3.5;

fn = strcat(working_dir, 'A_', label, num2str(d), '_logkt', num2str(logkt_max), '.asc');
A.nodata = -9999;
A.grid(idx) = A.nodata;
idx2 = A.grid == nan;
A.grid(idx2) = A.nodata;
mat2dem(A, fn);

fn = strcat(working_dir, 'logkt_', label, num2str(d), '_logkt', num2str(logkt_max), '.asc');
KT.grid = log10(KT.grid);
KT.nodata = -9999;
KT.grid(idx) = KT.nodata;
idx2 = KT.grid == nan;
KT.grid(idx2) = KT.nodata;
KT.grid(KT.grid == -inf) = KT.nodata;
mat2dem(KT, fn);

fn = strcat(working_dir, 'ANG_', label, num2str(d), '_logkt', num2str(logkt_max), '.asc');
ANG.nodata = -9999;
ANG.grid(idx) = ANG.nodata;
idx2 = ANG.grid == nan;
ANG.grid(idx2) = ANG.nodata;
mat2dem(ANG, fn);

fn = strcat(working_dir, 'SNR_', label, num2str(d), '_logkt', num2str(logkt_max), '.asc');
SNR.nodata = -9999;
SNR.grid(idx) = SNR.nodata;
idx2 = SNR.grid == nan;
SNR.grid(idx2) = SNR.nodata;
mat2dem(SNR, fn);

saverun_dilated(d, nanidx, working_dir, label, A, KT, ANG, SNR);

end
