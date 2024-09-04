function [lattice_mu,avg_spin,tot_energy,eff] = runIsingModel(lattice_mu,t, c, h, graph)
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
    dE = energyDif(1,lattice_mu,lattice_v,h);
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
    tot_energy(i) = energy(lattice_mu, h);
    % Las lineas que siguen permiten hacer una animacion de la evolucion del sistema
    if mod(i,1000) == 0 % Si queremos que incluya mas pasos tomamos el modulo con respecto a un numero menor
        figure(5)
        imagesc(lattice_mu)
    end
    figure(5)
    imagesc(lattice_mu, [-1 1])
    i
end

eff = count/t; % calcula la eficiencia, o el numero de cambios que se realizan sobre el numero de pasos totales

% Realizamos las graficas de la magnetizacion y energia dependiendo del
% valor asignado a graph
if graph
    figure(1)
    plot(1:t,tot_energy)
    title('Energia vs. tiempo')
    xlabel('tiempo')
    ylabel('E(J)')
    
    
    figure(2)
    plot(1:t,avg_spin)
    title('Magnetizacion del Lattice vs. tiempo')
    xlabel('tiempo')
    ylabel('M')
    
    figure(3)
    imagesc(Loriginal)
    title('Lattice Original')
    
    figure(4)
    imagesc(lattice_mu)
    title('Lattice Final')
end
end