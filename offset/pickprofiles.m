function swaths = pickprofiles(dem, radius)

swaths = {};

PX = [];
PY = [];

for(i=1:2)
    [x, y, b] = ginput(1);
    if(b == 1)
        plot(x, y, 'r+')
        PX = [PX; x];
        PY = [PY; y];
    else
        flag = 0;
        break;
    end
end

endpts = [PX, PY];
swaths = swathaxis(endpts, dem, radius, 20);

plot(PX, PY, 'r-', 'linewidth', 1.5)

end
