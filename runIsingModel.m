function [lattice_mu,avg_spin,tot_energy,eff] = runIsingModel(lattice_mu,t, c, h, graph)
% [lattice_mu,avg_spin,tot_energy,eff] = runIsingModel(lattice_mu,t, c, h, graph)
% lattice_mu : initial lattice                                                                       [INPUT]
% t          : number of iterations                                                                  [INPUT]
% c          : value of the constant beta                                                            [INPUT]
% h          : matrix with the same dimensions as the lattice and the H-field values at every point  [INPUT]
% graph      : boolean, if true shows plot with results                                              [INPUT]
% lattice_mu : final lattice                                                                         [OUTPUT]
% avg_spin   : vector storing the magnetization of the lattice at each time step                     [OUTPUT]
% tot_energy : vector storing the energy of the lattice at each time step                            [OUTPUT]
% eff        : scalar, number of spin flips per time step                                            [OUTPUT]
Loriginal = lattice_mu;

count = 1;
avg_spin = zeros(1,t);
tot_energy = zeros(1,t);

for i = 1:t
    r = 1 + floor(numel(lattice_mu)*rand); % selects the spin to be flipped
    lattice_v = lattice_mu;
    lattice_v(r) = -lattice_v(r);
    dE = energyDif(1,lattice_mu,lattice_v,h);
    if dE < 0 % v state must have less energy than mu state
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
    tot_energy(i) = energy(lattice_mu, h);
    % Following lines are intended to produce an animation of the evolution process
    if mod(i,1000) == 0 
        figure(5)
        imagesc(lattice_mu)
    end
    figure(5)
    imagesc(lattice_mu, [-1 1])
    i
end

eff = count/t; % efficiency, defined as the number of times a spin flip occurred over the number of time steps

% Magnetization and Energy graphs
if graph
    figure(1)
    plot(1:t,tot_energy)
    title('Energy vs. time')
    xlabel('time')
    ylabel('E(J)')
    
    
    figure(2)
    plot(1:t,avg_spin)
    title('Lattice Magnetization vs. time')
    xlabel('time')
    ylabel('M')
    
    figure(3)
    imagesc(Loriginal)
    title('Lattice Original')
    
    figure(4)
    imagesc(lattice_mu)
    title('Final Lattice')
end
end
