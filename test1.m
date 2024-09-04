clear, clc, close all, format long

lattice_mu = createLattice(20,20,0.75);
t = 5*10^4;
c = 0.8;
H = zeros(20,20);
[lattice_v,avg_spin,tot_energy, eff] = runIsingModel(lattice_mu, t,c, H, false);

