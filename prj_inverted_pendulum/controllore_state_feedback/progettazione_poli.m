%% ======================= VISUALIZZO I POLI DI A ===========================
disp('Poli A:');
disp(eig(A));

%% ========== INSTABILITA', ALLORA DECIDO CHE POLI VOGLIO OTTENERE ==========
des = [complex(-4, 2), complex(-4, -2), -9, -10];

%% ========= TROVO IL VALORE DI K (X'=(A-BK)X) PER OTTENERE TALI POLI =======
K = place(A,B,des);
Acl = A - B*K;
disp('Poli closed-loop:');
disp(eig(Acl));

%% ============ CREAZIONE DEL NUOVO SISTEMA STABILE IN SPAZIO DI STATO ======
sys_cl = ss(Acl,B,C,D);


%% astatismo in frequenza

F = tf(sys_cl);
s = tf('s');

k = 1;
G = k/s;

T = feedback(G*F, 1);
bode(T)

step(T)
