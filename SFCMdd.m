function [U,G,Jt,Jc] = SFCMdd(E,K,m,T,epsilon,q,Dm)
%{
Implements the algorithm 'Partitioning Fuzzy K-Medoids Clustering Algorithm Based on a Single Dissimilarity Matrix'
for clustering the data objects present in E (one per row) in K clusters represented by prototypes with length q.
m is a coeficient used in the calculus of the membership degree of the objects.
T is the max number of iterations.
epsilon is the stopping threshold (0 < epsilon < 1).
Dm is the dissimilarity matrix.

Reference:	de Carvalho, F. A. T., LeChevallier, Y., de Melo, F. M. -
	'Relational Partitioning Fuzzy Clustering Algorithms Based on Multiple Dissimilarity Matrices', Sec. 2.1, 2012.
%}
[n p] = size(E);
G = zeros(K,q);%colect the indexes of the prototypes objects.
Jt = zeros(1,T);
t = 1;
if ~(T > 1) || ~(epsilon > 0 && epsilon < 1)
	error('SFCMdd.m: epsilon must be between 0 and 1. And T must be grater than 1: epsilon = %d\nT = %d',epsilon,T);
end
%choosing ramdomly the prototypes
for k=1:K
	for j=1:q
		l = mod(floor(rand()*1000),n);
		l = l + 1;%l = {1,...,n}
		Gk = G(k,:);
        while ismember(l,Gk)
			l = mod(floor(rand()*1000),n) + 1;
        end
		G(k,j) = l;
	end
end
%initial membership degree matrix
U = zeros(n,K);
for i=1:n
	for k=1:K
		Gk = G(k,:);
		sumN = 0;
		sumD = 0;
		for iGk=1:q
			sumN = sumN + Dm(i,Gk(iGk));
		end
		for h=1:K
			Gh = G(h,:);
			sumh = 0;
			for iGh=1:q
				sumh = sumh + Dm(i,Gh(iGh));
			end
			sumD = sumD + (sumN/sumh)^(1/(m-1));
		end
		U(i,k) = 1/sumD;
	end	
end
%Calculus of the initial value for the objective function J
Jt(t) = J(U,G,m,E,q,Dm);
%iterations
t = t + 1;
threshold = epsilon + 1.1;
while (threshold > epsilon) && (t <= T)
	%Finding better prototypes
	Gstar = zeros(K,q);% G*
	vt = zeros(1,n);
	for k=1:K
		iGkstar = 1;
		for h=1:n
			sumh = 0;
			for i=1:n
				sumh = sumh + (U(i,k))^m * Dm(i,h);
			end
			vt(h) = sumh;
		end
		while iGkstar <= q
			[minx , l] = min(vt);
			Gkstar = Gstar(k,:);
			if ~ismember(l,Gkstar)
				Gstar(k,iGkstar) = l;
				vt(l) = (2^31);
				iGkstar = iGkstar + 1;
			end
		end
	end
	G = Gstar;
	%finding better fuzzy partition
	for i=1:n
		for k=1:K
			Gk = G(k,:);
			sumN = 0;
			sumD = 0;
			for iGk=1:q
				sumN = sumN + Dm(i,Gk(iGk));
			end
			for h=1:K
				Gh = G(h,:);
				sumh = 0;
				for iGh=1:q
					sumh = sumh + Dm(i,Gh(iGh));
				end
				sumD = sumD + (sumN/sumh)^(1/(m-1));
			end
			U(i,k) = 1/sumD;
		end	
	end
	%Calculus of the new value for the objective function J
	Jt(t) = J(U,G,m,E,q,Dm);
	threshold = abs(Jt(t-1) - Jt(t));
	Jc = Jt(t-1);
	t = t + 1;
end
fprintf('Finished in %u iterations\n',t-1);
end
