function E = extraHamil(lattice)
% E = extraHamil(lattice)
% lattice : lattice cuya energia queremos calcular [INPUT]
% E       : escalar, energia del lattice           [OUTPUT]

[n1,n2] = size(lattice);
sum = 0;
J = 1;

for i = 1:n1
	for j = 1:n2
		for k = 1:n1
			for l = 1:n2
				if i~=k || j ~= l % si no son el mismo elemento del lattice
					sum = sum+lattice(i,j)*lattice(k,l)/(sqrt(dot([i,j]-[k,l],[i,j]-[k,l])));
				end
			end			
		end 
	end
end
E = -J*sum;
end
