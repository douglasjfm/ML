function r = Rand(U)
%   Calculates the Rand index between two partition Represented by U
%     E is the set of N objects (one per row)
%     U a Nx2 matrix for the membership degrees
% of each object over the 2 clusters
[n K] = size(U);
%number of elements
a = 0;
b = 0;
for i=1:n
    ui = U(i,:);
    for j=1:n
        uj = U(j,:);
        if j ~= i
            if (ui(1) > ui(2) && uj(1) > uj(2)) || (ui(1) < ui(2) && uj(1) < uj(2))
                a = a + 1;
            else
                b = b + 1;
            end
        end
    end
end
            
        

end

