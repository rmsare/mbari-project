function [noise_level, zfilt] = calc_prof_noiselevel(z, x, dx)

%z = detrend(z);
fs = 1/dx;
fN = 1/(2*dx);
n = numel(z);
freqs = [0:n-1]*fs/n;
nmax = ceil(n/2);
Z = fft(z);
A = abs(Z);

A = A(1:nmax);
[mean(A) mean(A) + std(A)]
idx_max = find(A > mean(A) + std(A));
foffset = 2;
fmax = freqs(max(idx_max)) - foffset;
B = freqs > fmax;
B = [B(1:nmax) fliplr(B(1:nmax-1))];
Zfilt = Z.*B;
zfilt = real(fftshift(ifft(Zfilt)));
noise_level = range(zfilt)/2;

% plot spectra for testing
freqs = freqs(1:nmax);
figure
subplot(2,1,1)
hold on
plot(freqs, A, 'k-')
idx = find(A > median(A));
plot(freqs(idx), A(idx), 'r+')
plot(freqs(idx_max), A(idx_max), 'g+')
xlabel('wavenumber (m^{-1})')
ylabel('A')

subplot(2,1,2)
hold on
Z = Z(1:nmax);
plot(freqs(1:nmax), abs(Z(1:nmax)).^2, 'k-')
plot(freqs(1:nmax), abs(Zfilt(1:nmax)).^2, 'r-')
plot(freqs(1:nmax), B(1:nmax), 'k-')

xlabel('wavenumber (m^{-1})')
ylabel('|A|^2')
legend('orig', 'filtered')

figure
subplot(2,1,1)
hold on
plot(x, z, 'k-')
plot(x, zfilt, 'k--')
xlabel('x (m)')
ylabel('z (m)')
legend('profile', 'filtered');

subplot(2,1,2)
hold on
plot(freqs(1:nmax), (A(1:nmax)).^2, 'k-')
plot(freqs(1:nmax), abs(Zfilt(1:nmax)).^2, 'r--')
xlabel('wavenumber (m^{-1})')
ylabel('|A|^2')

end
