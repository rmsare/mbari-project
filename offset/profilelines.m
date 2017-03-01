function [L, dl] = profilelines(u1, u2, radius, nlines, n)

u = u2 - u1;
un = u./norm(u);

if(nargin < 5)
    n = [-u(2); u(1)];
end
if(nargin < 4)
    dl = 10;
    nlines = floor(norm(u)/dl);
else
    dl = str2num(sprintf('%2.1f', norm(u)/nlines)); % R2013 compatbility...
    %dl = round(norm(u)/nlines, 1)
end

if(n(1) > 0)
    n = -n;
end

n = n./norm(n);

L = [];
p = u1;

for(i=1:nlines)
    p1 = p + radius*n; 
    p2 = p - radius*n;
    p = p + un*dl;
    L = [L; p1'; p2'];
end

end
