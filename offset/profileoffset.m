function offset = profileoffset(swath1, swath2, fun1, fun2)

if(nargin < 3)
    fun1 = @(v) nanmax(v);
    fun2 = @(v) nanmin(v);
end

zfan = swath1.meanz; 
zfan = (zfan - nanmean(zfan))/nanstd(zfan);
xfan = unique(swath1.pl);

zscar = swath2.meanz;
zscar = (zscar - nanmean(zscar))/nanstd(zscar);
xscar = unique(swath2.pl);

peak = find(zfan == fun1(zfan));
trough = find(zscar == fun2(zscar));

if(peak == 1 | peak == length(zfan) | trough == 1 | trough == length(zscar))
    offset = nan;
else
    offset = abs(xfan(peak) - xscar(trough));
    plot(swath1.lx(peak), swath1.ly(peak), 'r.', 'markersize', 5)
    plot(swath2.lx(trough), swath2.ly(trough), 'r.', 'markersize', 5)
end

end
