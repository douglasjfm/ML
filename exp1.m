function [u,g,j] = exp1()
E = read_E();
[n p] = size(E);
u = zeros(100,n,2);
g = zeros(100,2,2);
j = zeros(100,1);
dm = zeros(n,n);
for i=1:n
    for j=1:n
        dm(i,j) = D(i,j,E);
    end
end
for i=1:100
[U,G,J,c] = SFCMdd(E,2,2,150,0.0000000001,2,dm);
u(i,:,:) = U(:,:);
g(i,:,:) = G(:,:);
j(i) = c;
end
end

%{
Results:
U(91) -> In U91.txt
G1 = e147,e368;
G2 = e300,e13;
j(91) = 5333.3;
%}
