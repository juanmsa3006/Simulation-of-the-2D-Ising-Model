clc, clear, close all, format long

lattice_mu = createLattice(10,10,0.5);
t = 10^6;
kbT = 1.5;
beta = 5;

H = [ones(5,5), -1*ones(5,5);
    -1*ones(5,5), ones(5,5)];


[lattice_f,~,~, ~] = runIsingModel(lattice_mu,t,beta,zeros(10,10), false); % evolucion sin campo magnetico
[lattice_f2,~,~,~] = runIsingModel(lattice_mu,t,beta,H, false); % evolucion con campo magnetico
%% Graficas

figure(1)
subplot(1, 2, 1)
imagesc(lattice_f)
title('Lattice Final con H = 0')

subplot(1,2,2)
imagesc(lattice_f2)
title('Lattice Final con H distinto de 0')

