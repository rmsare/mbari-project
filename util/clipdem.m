function clipped = clipdem(dem, value, compfn)

if(nargin < 3)
    compfn = @(v) isnan(v);
end
if(nargin < 2)
    value = nan;
end

grid = dem.grid;
[m, n] = size(dem.grid);
row = [];
col = [];

topflag = 0;
botflag = 0;
currtopval = inf;
currbotval = inf;
flag = 1;
i = 1;
j = m;
rowsums = sum(compfn(grid), 2);

while(flag)
    if(~botflag)
        lastbotval = currbotval;
        currbotval = rowsums(i);

        if(lastbotval < currbotval)
            row = [row i-1];
            botflag = 1;
        else
            i = i+1;
        end
    end
    if(~topflag)
        lasttopval = currtopval;
        currtopval = rowsums(j); 

        if(lasttopval < currtopval)
            row = [row j+1];
            topflag = 1;
        else
            j = j-1;
        end
    end

    flag = ~(topflag & botflag); 
end

leftflag = 0;
rightflag = 0;
currleftval = inf;
currrightval = inf;
flag = 1;
i = n;
j = 1;
colsums = sum(compfn(grid), 1);
maxval = max(colsums);

while(flag)
    if(~rightflag)
        currrightval = colsums(i);

        if(currrightval < maxval)
            col = [col i+1];
            rightflag = 1;
        else
            i = i-1;
        end
    end
    if(~leftflag)
        currleftval = colsums(j);

        if(currleftval < maxval)
            col = [col j-1];
            leftflag = 1;
        else
            j = j+1;
        end
    end

    flag = ~(leftflag & rightflag); 
end

clipped = dem;
clipped.xllcenter = 0;
clipped.yllcenter = 0;
clipped.grid = grid(min(row):max(row), min(col):max(col));
[clipped.ny, clipped.nx] = size(clipped.grid);
if(clipped.nx > clipped.ny)
    clipped.grid = clipped.grid';
    tmp = clipped.ny;
    clipped.ny = clipped.nx;
    clipped.nx = tmp;
end
clipped = computeslopeaz(clipped);

end
