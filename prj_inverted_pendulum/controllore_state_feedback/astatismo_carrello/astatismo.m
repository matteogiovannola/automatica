A_aug = [A, zeros(4,1); -C, 0];
B_aug = [B; 0];
des_aug = [complex(-4, 2), complex(-4, -2), -10, -9, -2];
K_aug = place(A_aug, B_aug, des_aug);

Acl_aug = A_aug - B_aug * K_aug;

Bcl_aug = [0; 0; 0; 0; 1]; 

Ccl_aug = [0, 0, 1, 0, 0]; 

Dcl_aug = 0;
sys_cl_aug = ss(Acl_aug, Bcl_aug, Ccl_aug, Dcl_aug);

step(sys_cl_aug);

n = size(A,1);

%% sforzo di controllo
C_u = -K_aug;
sys_u = ss(Acl_aug, Bcl_aug, C_u, 0);
figure
step(sys_u)
%%
% 1. Calcolo della funzione di guadagno d'anello L(s) al canale d'ingresso
% Nota: Usiamo le matrici AUMENTATE ma APERTE (A_aug, B_aug) e come "uscita" usiamo il guadagno K_aug
L = ss(A_aug, B_aug, Ka, 0);

% 2. Calcolo della Funzione di Sensibilità Generale S(s) dal feedback
% Poiché è ad un solo ingresso (SISO sul canale di controllo u), vale S = 1 / (1 + L)
S_generale = feedback(1, L);

figure
bodemag(S_generale)
grid on
title('Funzione di Sensibilità Generale S(s) tagliata all''ingresso u')