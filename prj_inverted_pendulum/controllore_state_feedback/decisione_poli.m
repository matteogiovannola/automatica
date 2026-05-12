%% ======================= VISUALIZZO I POLI DI A ===========================
disp('Poli A:');
disp(eig(A));

%% ========== INSTABILITA', ALLORA DECIDO CHE POLI VOGLIO OTTENERE ==========
p_des = [complex(-2, 2.74), complex(-2, -2.74) -10 -12];

%% ========= TROVO IL VALORE DI K (X'=(A-KB)X) PER OTTENERE TALI POLI =======
K = place(A,B,p_des);
Acl = A - B*K;
disp('Poli closed-loop:\n');
disp(eig(Acl));

%% ============ CREAZIONE DEL NUOVO SISTEMA STABILE IN SPAZIO DI STATO ======
sys_cl = ss(Acl,B,C,D);

%% ===================== CONDIZIONI INIZIALI ================================
x0 = [0 0 0.15 0];

%% ================ SIMULAZIONE DEL MODELLO CON TALI CONDIZIONI INIZIALI ====
initial(sys_cl,x0);

