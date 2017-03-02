function swaths = swathaxis(endpts, dem, radius, nlines, n)

swaths = {};
swathradius = 5;
dx = 1; 

u1 = endpts(1,:)';
u2 = endpts(2,:)';

if(nargin < 4)
    u = u2 - u1;
    swathradius = 5;
    axislength = norm(u, 2);
    nlines = floor(axislength/(2*swathradius))
    [L, dl] = profilelines(u1, u2, radius, nlines);
elseif(nargin < 5)
    [L, dl] = profilelines(u1, u2, radius, nlines);
else
    [L, dl] = profilelines(u1, u2, radius, nlines, n);
end

j = 1;

for(i=1:2:length(L))
    endpts = [L(i,:); L(i+1,:)];
    swaths{j} = swathprofile(dem, endpts, swathradius, dx);
    swaths{j}.dl = dl;
    j = j+1;
end
