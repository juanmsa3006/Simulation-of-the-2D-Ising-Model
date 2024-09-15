function E = extraHamil(lattice)
% E = extraHamil(lattice)
% lattice : lattice whose energy we want to calculate [INPUT]
% E       : scalar, energy of the lattice             [OUTPUT]

[n1,n2] = size(lattice);
sum = 0;
J = 1;

for i = 1:n1
	for j = 1:n2
		for k = 1:n1
			for l = 1:n2
				if i~=k || j ~= l % if they are not the same element
					sum = sum+lattice(i,j)*lattice(k,l)/(sqrt(dot([i,j]-[k,l],[i,j]-[k,l])));
				end
			end			
		end 
	end
end
E = -J*sum;
end
