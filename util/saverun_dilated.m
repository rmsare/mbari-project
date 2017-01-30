function saverun_dilated(d, nanidx, working_dir, label, A, KT, ANG, SNR)

idx = nanidx;

logkt_max = 3.5;

fn = strcat(working_dir, 'A_', label, num2str(d), '_dilated_logkt', num2str(logkt_max), '.asc');

A.grid(A.grid == A.nodata) = 0;
A.grid(isnan(A.grid)) = 0;
se = strel('square', 5);
A.grid = imdilate(A.grid, se);
A.grid(A.grid == 0) = A.nodata;

mat2dem(A, fn);

fn = strcat(working_dir, 'logkt_', label, num2str(d), '_dilated_logkt', num2str(logkt_max), '.asc');

KT.grid(KT.grid == KT.nodata) = 0;
KT.grid(isnan(KT.grid)) = 0;
KT.grid = imdilate(KT.grid, se);
KT.grid(KT.grid == 0) = KT.nodata;

mat2dem(KT, fn);

fn = strcat(working_dir, 'ANG_', label, num2str(d), '_dilated_logkt', num2str(logkt_max), '.asc');

ANG.grid(ANG.grid == ANG.nodata) = 0;
ANG.grid(isnan(ANG.grid)) = 0;
ANG.grid = imdilate(ANG.grid, se);
ANG.grid(ANG.grid == 0) = ANG.nodata;

mat2dem(ANG, fn);

fn = strcat(working_dir, 'SNR_', label, num2str(d), '_dilated_logkt', num2str(logkt_max), '.asc');

SNR.grid(SNR.grid == SNR.nodata) = 0;
SNR.grid(isnan(SNR.grid)) = 0;
SNR.grid = imdilate(SNR.grid, se);
SNR.grid(SNR.grid == 0) = SNR.nodata;

mat2dem(SNR, fn);

end
