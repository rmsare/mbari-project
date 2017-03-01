function swath = projectline(swath, u1, u2, o)

lx = swath.lx;
ly = swath.ly;

u1 = u1 - o;
u2 = u2 - o;
u = u1 - u2;

swath.distfault = zeros(length(lx),1);

for(i=1:length(lx))
    v = [lx(i); ly(i)];
    v = v - o;
    vu1 = v - u1;
    vu1rot = dot(vu1, u).*(u./norm(u).^2);
    lu(:,i) = u1 + vu1rot + o;
    swath.distfault(i) = norm(lu(:,i) - v - o, 2);
end


lu = [u1 + o lu];
swath.pl = [cumsum(sqrt((lu(1, 2:end)-lu(1, 1:end-1)).^2 + (lu(2, 2:end)-lu(2, 1:end-1)).^2))];

end
