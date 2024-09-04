clear, clc, close all

kBT = [linspace(0.01,2,7), linspace(2.001, 2.4, 9), linspace(2.45,4, 7),linspace(4.001,10, 7)];
t = 10^5;
H1 = ones(20,20);
H2 = -1*H1;
H3 = [-1*ones(10,20); ones(10,20)];
MH = zeros(20,20,3); % Contiene todas las matrices de los campos magneticos
MH(:,:,1) = H1;
MH(:,:,2) = H2;
MH(:,:,3) = H3;
all_spin  =zeros(3,numel(kBT));

%%
for j = 1:3
    H = MH(:,:,j);
    disp(['Campo H numero: ', num2str(j)])
    for i = 1:numel(kBT)
        beta = 1./(kBT(i));
        lattice_mu = createLattice(20,20,0);
        [lattice_final,avg_spin,tot_energy] = runIsingModel(lattice_mu,t,beta,H, false);
        all_spin(j,i) = (sum(avg_spin(end-49:end))./50);
        disp(['Simulacion numero: ', num2str(i), '/30'])
    end
end

%% Graficas
figure(1)

plot(kBT, all_spin(1,:), 'g o','markerfacecolor', 'g')
hold on
plot(kBT, all_spin(2,:), 'b o', 'markerfacecolor', 'b')
hold on
plot(kBT, all_spin(3,:), 'k o', 'markerfacecolor', 'k')
hold on
%xline(2.269, 'r')
grid on
xlabel('k_BT (J)')
ylabel('M')
title('Temperatura de transicion de estado')

legend('H_1', 'H_2', 'H_3','Location','northeast')