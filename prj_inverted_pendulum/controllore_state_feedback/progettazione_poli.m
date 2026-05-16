%% ======================= VISUALIZZO I POLI DI A ===========================
disp('Poli A:');
disp(eig(A));

%% ========== INSTABILITA', ALLORA DECIDO CHE POLI VOGLIO OTTENERE ==========
des = [complex(-2, 1.74), complex(-2, -1.74) -7 -6];

%% ========= TROVO IL VALORE DI K (X'=(A-BK)X) PER OTTENERE TALI POLI =======
K = place(A,B,des);
Acl = A - B*K;
disp('Poli closed-loop:');
disp(eig(Acl));

%% ============ CREAZIONE DEL NUOVO SISTEMA STABILE IN SPAZIO DI STATO ======
sys_cl = ss(Acl,B,C,D);

