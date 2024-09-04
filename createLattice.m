function L = createLattice(n1,n2,p)
% L = createLattice(n1,n2,p)
% n1 : escalar, numero de filas                                                [INPUT]
% n2 : escalar, numero de columnas                                             [INPUT]
% p  : escalar en el rango (0,1), probabilidad de que cualquier entrada sea -1 [INPUT]
% L  : lattice, matriz n1xn2 con entradas 1 y -1                               [OUTPUT]

L = rand(n1,n2);
for i = 1:n1*n2
    if L(i) > p
        L(i) = 1;
    else
        L(i) = -1;
    end
end
