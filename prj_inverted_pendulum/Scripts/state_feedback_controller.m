%% ====================== SCELTA DEI POLI ==================================
zeta = 0.75;    % Smorzamento scelto

% Angolo e pendenza del cono
theta = acos(zeta);
m = tan(theta);

% Asse reale 
sigma = linspace(-10, 0, 500);

% Rette del cono
omega_pos = m * (-sigma);
omega_neg = -m * (-sigma);

% Plot
figure;
plot(sigma, omega_pos, 'r', 'LineWidth', 2); hold on;
plot(sigma, omega_neg, 'r', 'LineWidth', 2);

% Asse reale e immaginario
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

% ========== INSTABILITA', ALLORA DECIDO CHE POLI VOGLIO OTTENERE (TENTATIVO 1) ==========
des_1 = [complex(-2, 1), complex(-2, -1), -7, -8];

% ========= TROVO IL VALORE DI K (X'=(A-BK)X) PER OTTENERE TALI POLI =======
K_1 = place(A,B,des_1);
Acl_1 = A - B*K_1;
disp('Poli ciclo chiuso::');
disp(eig(Acl_1));

sis_1 = ss(Acl_1, B, C_theta, D);

figure
step(sis_1); grid on;

% ============ SPECIFICA NON RISPETTATA, SI RIPROGETTANO I POLI (TENTATIVO 2) ========
des_2 = [complex(-4, 2), complex(-4, -2), -9, -10];

% ========= TROVO IL VALORE DI K (X'=(A-BK)X) PER OTTENERE TALI POLI =======
K_2 = place(A,B,des_2);
Acl_2 = A - B*K_2;
disp('Poli ciclo chiuso::');
disp(eig(Acl_2));

sis_2 = ss(Acl_2, B, C_theta, D);

figure
step(sis_2); grid on;   % Specifica rispettata

%% ============ CREAZIONE DEL NUOVO SISTEMA AUMENTATO (ASTATICO) IN SS (CAMBIO USCITA) (TENTATIVO 1) =======
A_aum = [A, zeros(4,1); -C_x, 0];
B_aum = [B; 0];


des_aum_1 = [complex(-4, 2), complex(-4, -2), -9, -10, -1];   % Poli desiderati

K_aum_1 = place(A_aum, B_aum, des_aum_1);   % Trovo il valore di K 

% Sistema aumentato
Acl_aum_1 = A_aum - B_aum * K_aum_1;
Bcl_aum = [0; 0; 0; 0; 1]; 
Ccl_aum_x = [1, 0, 0, 0, 0]; 
Ccl_aum_theta = [0, 0, 1, 0, 0]; 
Dcl_aum = 0;

sys_cl_aum_x_1 = ss(Acl_aum_1, Bcl_aum, Ccl_aum_x, Dcl_aum);
sys_cl_aum_theta_1 = ss(Acl_aum_1, Bcl_aum, Ccl_aum_theta, Dcl_aum);

% Risposta al gradino (posizione carrello), OK
figure
step(sys_cl_aum_x_1); grid on;

% Risposta al gradino (angolo pendolo), non rispetta le specifiche
figure
step(sys_cl_aum_theta_1); grid on;

% ============ SPECIFICA NON RISPETTATA, SI RIPROGETTANO I POLI (TENTATIVO 2) ========
des_aum_2 = [complex(-1.5, 0.4), complex(-1.5, -0.4), -10, -8, -0.4];   % Poli desiderati

K_aum_2 = place(A_aum, B_aum, des_aum_2);   % Trovo il valore di K 

% Sistema aumentato
Acl_aum_2 = A_aum - B_aum * K_aum_2;

sys_cl_aum_x_2 = ss(Acl_aum_2, Bcl_aum, Ccl_aum_x, Dcl_aum);
sys_cl_aum_theta_2 = ss(Acl_aum_2, Bcl_aum, Ccl_aum_theta, Dcl_aum);

% Risposta al gradino (posizione carrello), OK
figure
step(sys_cl_aum_x_2); grid on;

% Risposta al gradino (angolo pendolo), OK
figure
step(sys_cl_aum_theta_2); grid on;





