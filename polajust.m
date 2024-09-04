function [c,dc,dyav,Padj] = polajust(x,y,g)
% polajust - Ajuste/interpolacion polinomico de datos
% [c,dc,dyav,Padj] = polajust(x,y,g) ,
% x(n) : Valores coordenadas x [input] como 1xn
% y(n) : Valores coordenadas y [input] como 1xn
% g(1) : Grado polinomio de ajuste [input]
% c(g+1,1) : Coef. polinomio P(x) = c(1)+c(2)*x+c(3)*x^2+... [output]
% dc(g+1,1) : Incertidumbre de los coeficientes [output]
% dyav(1) : Desviacion promedio de los datos y [output]
% Padj (function): Funcion anonima para P(x) [output]
n = numel(x) ; % Numero de datos
B = x(:).^(0:g) ; % Matriz n x (g+1) para minimos cuadrados
c=B\y(:) ; % Coeficientes ajuste polinomico
dy = B*c-y(:) ; % Desviaciones datos y
dyav = sqrt(dot(dy,dy)/max(n-g-1,1)) ; % Desv. promedio
G = inv(B'*B) ; % Matriz G = inv(B'*B)
dc = sqrt(diag(G)).*dyav ; % Incertidumbres c
Padj =@(x) 0 ; % Preasignacion funcion Padj(x)
for k = 0:g % Sumamos secuencialmente los monomios
    Padj =@(x) Padj(x) + c(k+1).*x.^k ;
end
end