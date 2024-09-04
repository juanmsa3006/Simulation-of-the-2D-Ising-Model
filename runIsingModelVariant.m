function [lattice_mu,avg_spin,tot_energy, eff] = runIsingModelVariant(lattice_mu,t, c, graph)
% [lattice_mu,avg_spin,tot_energy,eff] = runIsingModel(lattice_mu,t, c, h, graph)
% lattice_mu : lattice incial                                                            [INPUT]
% t          : numero de iteraciones realizadas                                          [INPUT]
% c          : valor de la constante beta                                                [INPUT]
% h          : matriz del mismo tamano que el lattice con los valores de H en cada punto [INPUT]
% graph      : boolean, si es verdadero grafica los resultado                            [INPUT]
% lattice_mu : lattice final                                                             [OUTPUT]
% avg_spin   : vector con la magnetizacion del lattice en cada paso temporal             [OUTPUT]
% tot_energy : vector con la energia total del lattice en cada paso temporal             [OUTPUT]
% eff        : escalar, numero de alteraciones de espin sobre pasos temporales           [OUTPUT]

Loriginal = lattice_mu;

count = 1;
avg_spin = zeros(1,t);
tot_energy = zeros(1,t);

for i = 1:t
    r = 1 + floor(numel(lattice_mu)*rand); % seleccionar paticula a cambiar spin
    lattice_v = lattice_mu;
    lattice_v(r) = -lattice_v(r);
    dE = extraHamil(lattice_v)-extraHamil(lattice_mu);
    if dE < 0 % estado v tiene menor energia que mu
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
    xlabel('tiempo')
    ylabel('E(J)')
    
    figure(2)
    plot(1:t,avg_spin)
    title('Magnetizacion vs. tiempo')
    xlabel('tiempo')
    ylabel('Magnetizacion total')
    
    figure(3)
    imagesc(Loriginal)
    title('Lattice Original')
    
    figure(4)
    imagesc(lattice_mu)
    title('Lattice Final')
end

end