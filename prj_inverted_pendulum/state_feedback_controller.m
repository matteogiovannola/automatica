%% ====================== SCELTA DEI POLI ==================================
zeta = 0.75;    % Smorzamento scelto

% angolo e pendenza del cono
theta = acos(zeta);
m = tan(theta);

% asse reale 
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

%% ======================= FISSO I POLI DI A ===============================
disp('Poli A:');
disp(eig(A));

% ========== INSTABILITA', ALLORA DECIDO CHE POLI VOGLIO OTTENERE ==========
des = [complex(-4, 2), complex(-4, -2), -9, -10];

% ========= TROVO IL VALORE DI K (X'=(A-BK)X) PER OTTENERE TALI POLI =======
K = place(A,B,des);
Acl = A - B*K;
disp('Poli closed-loop:');
disp(eig(Acl));

%% ============ CREAZIONE DEL NUOVO SISTEMA AUMENTATO (ASTATICO) IN SS =====
sys_cl = ss(Acl,B,C,D);

A_aug = [A, zeros(4,1); -C, 0];
B_aug = [B; 0];

des_aug = [complex(-4, 2), complex(-4, -2), -10, -8, -0.5]; % Poli desiderati

K_aug = place(A_aug, B_aug, des_aug);   % Trovo i valori di K 

% Sistema augmentato
Acl_aug = A_aug - B_aug * K_aug;
Bcl_aug = [0; 0; 0; 0; 1]; 
Ccl_aug = [0, 0, 1, 0, 0]; 
Dcl_aug = 0;

sys_cl_aug = ss(Acl_aug, Bcl_aug, Ccl_aug, Dcl_aug);

% Risposta al gradino
step(sys_cl_aug);

%% Sforzo di controllo
C_u = -K_aug;
sys_u = ss(Acl_aug, Bcl_aug, C_u, 0);
figure
step(sys_u)

