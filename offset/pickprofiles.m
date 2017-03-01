function swaths = pickprofiles(dem, radius)

figure
ploths(dem, 225, 5);
hold on
axis image
box on

xlims = [4.0599e5 4.0672e5];
ylims = [3.0871e6 3.0878e6];
xlim(xlims);
ylim(ylims);
axis xy;


swaths = {};

PX = [];
PY = [];
j = 1;
flag = 1;


while(flag)
    PX = [];
    PY = [];
    
    for(i=1:2)
        [x, y, b] = ginput(1)
        if(b == 1)
            plot(x, y, 'r+')
            PX = [PX; x];
            PY = [PY; y];
        else
            flag = 0;
            break;
        end
    end

    if(flag) 
        endpts = [PX, PY];
        swaths{j} = swathaxis(endpts, dem, radius);
        
        plot(PX, PY, 'r-', 'linewidth', 1.5)

        j = j + 1;
    end
end

end
