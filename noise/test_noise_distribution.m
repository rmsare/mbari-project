function test_noise_distribution(grid, th_rot)

if(nargin < 2)
    th_rot = 0;
end

%f = [0, 5, 50, 500];
f = [0 100];

p1 = figure;
subplot(2,1,1)
hold on
box on
ylabel('mean (m^{-1})')

subplot(2,1,2)
hold on
box on
xlabel('rotation angle (\circ)')
ylabel('std. dev. (m^{-1})')
p2 = figure;
p3 = figure;

for(i=1:numel(f))
    [ALPHA, M, S2] = calc_noise_distribution(grid, f(i));
    ALPHA = ALPHA + (180/pi)*th_rot;
    TH = ALPHA.*(pi/180);

    figure(p2)
    U = M.*cos(TH');
    V = M.*sin(TH');
    compass(U, V, 'k-')

    figure(p3)
    U = S2.*cos(TH');
    V = S2.*sin(TH');
    compass(U, V, 'r-')

end

%legend('0', '10', '100', '1000')
figure(p1)
legend('0', '50', 500')

end
