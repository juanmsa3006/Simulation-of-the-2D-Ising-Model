clc, clear, close all, format long

lattice_mu = createLattice(10,10,0.5);
t = 10^6;
kbT = 1.5;
beta = 5;

H = [ones(5,5), -1*ones(5,5);
    -1*ones(5,5), ones(5,5)];


[lattice_f,~,~, ~] = runIsingModel(lattice_mu,t,beta,zeros(10,10), false); % evolution in the absence of H-field
[lattice_f2,~,~,~] = runIsingModel(lattice_mu,t,beta,H, false); % evolution in the presence of H-field
%% Plots

figure(1)
subplot(1, 2, 1)
imagesc(lattice_f)
title('Final lattice with H = 0')

subplot(1,2,2)
imagesc(lattice_f2)
title('Final lattice with H different from 0')

