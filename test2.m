clc, clear, close all, format long

beta =  1/5;
t = 5*10^4;
lattice_mu = createLattice(20,20,0.75);
H = zeros(20,20);
[lattice_v,avg_spin,tot_energy, eff] = runIsingModel(lattice_mu,t,beta, H, true);
