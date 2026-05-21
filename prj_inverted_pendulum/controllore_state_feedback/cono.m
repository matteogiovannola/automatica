%%
% smorzamento scelto
zeta = 0.75;

% angolo e pendenza del cono
theta = acos(zeta);
m = tan(theta);

% asse reale (solo parte negativa)
sigma = linspace(-10, 0, 500);

% rette del cono
omega_pos = m * (-sigma);
omega_neg = -m * (-sigma);

% plot
figure;
plot(sigma, omega_pos, 'r', 'LineWidth', 2); hold on;
plot(sigma, omega_neg, 'r', 'LineWidth', 2);

% asse reale e immaginario
xline(0, '--k');
yline(0, '--k');

grid on;
axis equal;

xlabel('\sigma (parte reale)');
ylabel('\omega (parte immaginaria)');
title('Settore di smorzamento (cono) nel piano s');

xlim([-10 1]);
ylim([-10 10]);
