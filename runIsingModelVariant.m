function [lattice_mu,avg_spin,tot_energy, eff] = runIsingModelVariant(lattice_mu,t, c, graph)
% [lattice_mu,avg_spin,tot_energy,eff] = runIsingModel(lattice_mu,t, c, h, graph)
% lattice_mu : initial lattice                                                                      [INPUT]
% t          : number of iterations                                                                 [INPUT]
% c          : value of the constant beta                                                           [INPUT]
% h          : matrix of the same dimensions as the lattice with the H-field value at each point    [INPUT]
% graph      : boolean, if true plots the results                                                   [INPUT]
% lattice_mu : final lattice                                                                        [OUTPUT]
% avg_spin   : vector storing the magnetization of the lattice at each time step                    [OUTPUT]
% tot_energy : vector storing the energy of the lattice at each time step                           [OUTPUT]
% eff        : scalar, number of spins flipped per number of time steps                             [OUTPUT]

Loriginal = lattice_mu;

count = 1;
avg_spin = zeros(1,t);
tot_energy = zeros(1,t);

for i = 1:t
    r = 1 + floor(numel(lattice_mu)*rand); % selects spin to be flipped
    lattice_v = lattice_mu;
    lattice_v(r) = -lattice_v(r);
    dE = extraHamil(lattice_v)-extraHamil(lattice_mu);
    if dE < 0 % state v has less energy than state mu
        lattice_mu = lattice_v;
    end
    if dE > 0
        Pmu_v = exp(-c*dE);
        if rand < Pmu_v
            lattice_mu = lattice_v;
            count = count+1;
        end
    end
    
    avg_spin(i) = sum(sum(lattice_mu))/(numel(lattice_mu));
    tot_energy(i) = extraHamil(lattice_mu);
%     if mod(i,10000)
%         figure(5)
%         imagesc(lattice_mu)
%     end
%     figure(5)
%     imagesc(lattice_mu)
end

eff = count/t;

if graph
    figure(1)
    plot(1:t,tot_energy)
    title('E vs. t')
    xlabel('time')
    ylabel('E(J)')
    
    figure(2)
    plot(1:t,avg_spin)
    title('Magnetization vs. time')
    xlabel('time')
    ylabel('Total Magnetization')
    
    figure(3)
    imagesc(Loriginal)
    title('Lattice Original')
    
    figure(4)
    imagesc(lattice_mu)
    title('Final Lattice')
end

end
