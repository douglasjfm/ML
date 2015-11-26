function d = D(ie1,ie2,E)
l1 = length(E(ie1,:));
l2 = length(E(ie2,:));
e1 = E(ie1,:);
e2 = E(ie2,:);
if l1 ~= l2
	error('D.m: vectors do not have the same length');
end
d = 0;
for i=1:l1
    if e1(i) ~= e2(i)
		d = d + 1;
    end
end
end