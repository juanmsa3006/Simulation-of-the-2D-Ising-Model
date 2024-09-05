clear, clc, close all
kBT = 0:10:200;
kBT(1) = 0.001;
t = 10^3;
all_spin  =zeros(1,numel(kBT));

for i = 1:numel(kBT)
    beta = 1./(kBT(i));
    lattice_mu = createLattice(15,15,0);
    [lattice_final,avg_spin,tot_energy] = runIsingModelVariant(lattice_mu,t,beta, false);
    all_spin(i) = (sum(avg_spin(end-49:end))./50);
    disp(['Simulacion numero: ', num2str(i), '/21'])
end


%% Graficas
figure(1)

plot(kBT, all_spin, 'k o','markerfacecolor', 'k')
grid on
xlabel('k_BT (J)')
ylabel('M')
title('Temperatura de transicion de estado')
