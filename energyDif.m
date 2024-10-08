function dE = energyDif(J, lattice, lattice2, H)
% dE = energyDif(J, lattice, lattice2, H)
% J        : value of the J constant                                       [INPUT]
% lattice  : lattice before spin flip                                      [INPUT]
% lattice2 : lattice after spin flip                                       [INPUT]
% H        : matrix with the values of the magnetic field at each point    [INPUT]
% dE       : scalar, energy difference of both lattice configurations      [OUTPUT]

[a,b] = find(lattice ~= lattice2); % Find position of the flipped spin
[n1,n2] = size(lattice2); 

%% Boundary Conditions
horBoundary = 0;
verBoundary = 0;
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
        dE = -J*lattice2(a,b)*sum([lattice2(a-1,b), lattice2(a+1,b), lattice2(a,b-1), lattice2(a,b+1)]);
    end

    if verBoundary == 1
        dE = -J*lattice2(a,b)*sum([lattice2(a,b+1), lattice2(a-1,b), lattice2(a+1,b)]);
    end
    
    if verBoundary == 2
        dE = -J*lattice2(a,b)*sum([lattice2(a,b-1), lattice2(a-1,b), lattice2(a+1,b)]);
    end

    if verBoundary == 3
        dE = -J*lattice2(a,b)*sum([lattice2(a-1,b), lattice2(a+1,b)]);
    end
end

if horBoundary == 1 
    if verBoundary == 0
        dE = -J*lattice2(a,b)*sum([lattice2(a,b-1), lattice2(a,b+1), lattice2(a+1,b)]);
    end

    if verBoundary == 1
        dE = -J*lattice2(a,b)*sum([lattice2(a,b+1), lattice2(a+1,b)]);
    end

    if verBoundary == 2
        dE = -J*lattice2(a,b)*sum([lattice2(a,b-1), lattice2(a+1,b)]);
    end

    if verBoundary == 3
        dE = -J*lattice2(a,b)*sum([lattice2(a+1,b)]);
    end
end

if horBoundary == 2 
    if verBoundary == 0
        dE = -J*lattice2(a,b)*sum([lattice2(a,b-1), lattice2(a,b+1), lattice2(a-1,b)]);
    end

    if verBoundary == 1
        dE = -J*lattice2(a,b)*sum([lattice2(a-1,b), lattice2(a,b+1)]);
    end

    if verBoundary == 2
        dE = -J*lattice2(a,b)*sum([lattice2(a,b-1), lattice2(a-1,b)]);
    end
    
    if verBoundary == 3
        dE = -J*lattice2(a,b)*sum([lattice2(a-1,b)]);
    end
end

if horBoundary == 3
    if verBoundary == 0
        dE = -J*lattice2(a,b)*sum([lattice2(a,b-1), lattice2(a,b+1)]);
    end

    if verBoundary == 1
        dE = -J*lattice2(a,b)*sum([lattice2(a,b+1)]);
    end
    
    if verBoundary == 2
        dE = -J*lattice2(a,b)*sum([lattice2(a,b-1)]);
    end
    
    if verBoundary == 3
        dE = -J*lattice2(a,b)*sum([lattice2(a,b)]); 
    end
end
%% Evaluar la energia
dE = 2.*dE - lattice2(a,b).*H(a,b); 

end
