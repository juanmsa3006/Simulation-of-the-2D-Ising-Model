clc, clear, close all, format long


H1 = ones(20,20);
H2 = -1*H1;
H3 = [-1*ones(10,20); ones(10,20)];


figure(1)
subplot(1,3,1)
imagesc(H1,[-1 1])
title('H_1')
subplot(1,3,2)
imagesc(H2, [-1 1])
title('H_2')
subplot(1,3,3)
imagesc(H3, [-1 1])
title('H_3')
