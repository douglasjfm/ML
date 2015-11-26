function j = J(U,G,m,E,q,Dm)
[n K] = size(U);
j = 0;
for k=1:K	
	Gk = G(k,:);
    for i=1:n
		a = (U(i,k))^m;
		b = 0;
        for iGk=1:q
			b = b + Dm(i,Gk(iGk));
        end
		j = j + a * b;
    end
end
end
