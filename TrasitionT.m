clear, clc, close all
kBT = [linspace(0.01,2,4), linspace(2.001, 2.4, 6), linspace(2.45,4, 6),linspace(4.001,10, 4)];
t = 10^5;
all_spin  =zeros(1,numel(kBT)); % vector que almancenera los resultados de la magnetizacion de cada simulacion 
H  = zeros(20,20);
% Bucle que realiza una simulacion para cada valor de kBT
for i = 1:numel(kBT)
    beta = 1./(kBT(i));
    lattice_mu = createLattice(20,20,0);
    [lattice_final,avg_spin,tot_energy] = runIsingModel(lattice_mu,t,beta,H, false);
    all_spin(i) = (sum(avg_spin(end-49:end))./50);
    disp(['Simulacion numero: ', num2str(i), '/20'])
end

all_spin_neg  =zeros(1,numel(kBT));
H  = zeros(20,20);
for i = 1:numel(kBT)
    beta = 1./(kBT(i));
    lattice_mu = createLattice(20,20,1);
    [lattice_final,avg_spin,tot_energy] = runIsingModel(lattice_mu,t,beta,H, false);
    all_spin_neg(i) = (sum(avg_spin(end-49:end))./50);
    disp(['Simulacion numero: ', num2str(i), '/20'])
end


%% Grafica

figure(1)
plot(kBT, all_spin, 'g o','markerfacecolor', 'g')
hold on
plot(kBT, all_spin_neg, 'b o', 'markerfacecolor', 'b')
hold on
xline(2.269, 'r')

grid on
xlabel('k_BT (J)')
ylabel('M')
title('Temperatura de transicion de estado')

legend('Positivos', 'Negativos', 'k_BT_c = 2.269 J','Location','northeast')