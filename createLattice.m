function L = createLattice(n1,n2,p)
% L = createLattice(n1,n2,p)
% n1 : scalar, number of rows                                                [INPUT]
% n2 : scalar, number of columns                                             [INPUT]
% p  : scalar in the (0,1) range, probability that any cell is set to -1     [INPUT]
% L  : lattice, matrix n1xn2 with entries 1 and -1                           [OUTPUT]

L = rand(n1,n2);
for i = 1:n1*n2
    if L(i) > p
        L(i) = 1;
    else
        L(i) = -1;
    end
end
