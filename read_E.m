function data = read_E()
%Ler os dados
fid = fopen('dstictactoe.txt','rb');
str = fscanf(fid,'%c');
linhas = strsplit(str,'\n');
linhas = char(linhas);
[n p] = size(linhas);
p = length(strsplit(linhas(1,:),','));
data = zeros(n-1,p);
for i=1:(n-1)
    s = char(strsplit(linhas(i,:),','));
    data(i,:) = s;
end
end
