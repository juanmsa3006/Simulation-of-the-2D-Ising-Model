function E = energy(lattice, H)
% E = energy(lattice, H)
% lattice : lattice whose energy we want to calculate                       [INPUT]
% H       : matrix containing the value of the magnetic field at each point [INPUT]
% E       : scalar, energy of the lattice                                   [OUTPUT]

[n1,n2] = size(lattice);
E = 0;
%% Boundary Conditions
for a = 1:n1
    for b = 1:n2
        horBoundary = 0;
        verBoundary = 0;
        kernel = zeros(n1,n2); 

        if a == 1
            horBoundary = 1;
        end
        if a == n1
            horBoundary = 2;
        end
        
        if a == 1 && a == n1
            horBoundary = 3;
        end
        
        if b == 1
            verBoundary = 1;
        end
        if b == n2
            verBoundary = 2;
        end
        
        if b == 1 && b == n2
            verBoundary = 3;
        end
        
        if horBoundary == 0
            
            if verBoundary == 0
                kernel(a-1,b) = 1;
                kernel(a+1,b) = 1;
                kernel(a,b-1) = 1;
                kernel(a,b+1) = 1;
            end
        
            if verBoundary == 1
                kernel(a-1,b) = 1;
                kernel(a+1,b) = 1;
                kernel(a,b+1) = 1;
            end
            
            if verBoundary == 2
                kernel(a-1,b) = 1;
                kernel(a+1,b) = 1;
                kernel(a,b-1) = 1;
            end
        
            if verBoundary == 3
                kernel(a-1,b) = 1;
                kernel(a+b,b) = 1;
            end
        end
        
        if horBoundary == 1 

            if verBoundary == 0
                kernel(a,b-1) = 1;
                kernel(a,b+1) = 1;
                kernel(a+1,b) = 1;
            end
        
            if verBoundary == 1
                kernel(a,b+1) = 1;
                kernel(a+1,b) = 1;
            end
        
            if verBoundary == 2
                kernel(a,b-1) = 1;
                kernel(a+1,b) = 1;
            end
        
            if verBoundary == 3
                kernel(a+1,b) = 1;
            end
        end
        
        if horBoundary == 2 
            if verBoundary == 0
                kernel(a,b-1) = 1;
                kernel(a,b+1) = 1;
                kernel(a-1,b) = 1;
            end
        
            if verBoundary == 1
                kernel(a-1,b) = 1;
                kernel(a,b+1) = 1;
            end
        
            if verBoundary == 2
                kernel(a-1,b) = 1;
                kernel(a,b-1) = 1;
            end
            
            if verBoundary == 3
                kernel(a-1,b) = 1;
            end
        end
        
        if horBoundary == 3
            if verBoundary == 0
                kernel(a,b-1) = 1;
                kernel(a,b+1) = 1;
            end
        
            if verBoundary == 1
                kernel(a,b+1) = 1;
            end
            
            if verBoundary == 2
                kernel(a,b-1) = 1;
            end
            
            if verBoundary == 3
                % modelo 1x1
            end
        end
        
        E = E + lattice(a,b)*sum(sum(lattice.*kernel));
        
    end
end

Eh = sum(sum(lattice.*H)); % enrgy contribution from the magnetic field

E = -E-Eh;

end
