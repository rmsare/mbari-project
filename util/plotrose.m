function plotrose(ALPHA, V, sty, col)

if(nargin < 4)
    col = [0 0 0];
end
if(nargin < 3)
    sty ='ko';
end

nbins = floor(range(ALPHA)/10);
step = floor(range(ALPHA)/nbins);
alpha_lims = min(ALPHA):step:max(ALPHA);

alpha_centers = zeros(size(alpha_lims)-1); 
Vbinned = zeros(size(alpha_lims)-1);
for(i=1:numel(alpha_lims)-1)
    alpha_centers(i) = alpha_lims(i)+step/2; 
    idx = ALPHA >= alpha_lims(i) & ALPHA < alpha_lims(i+1);
    Vbinned(i) = mean(V(idx));
end

TH = ALPHA*(pi/180);
p1 = polar(TH, V, 'ko');
set(p1, 'Color', col', 'MarkerEdgeColor', [0.9 0.9 0.9], 'MarkerFaceColor', [0.9 0.9 0.9], 'MarkerSize', 5)
hold on
TH = alpha_centers*(pi/180);
p2 = polar(TH, Vbinned, sty);
set(p2, 'Color', col', 'MarkerEdgeColor', [0.25 0.25 0.25], 'MarkerFaceColor', col, 'MarkerSize', 10)

view([90 -90])

end
