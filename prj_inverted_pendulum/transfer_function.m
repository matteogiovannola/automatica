%% ========= CREAZIONE DEL SISTEMA IN SPAZIO DI STATO ===========
sys = ss(A,B,C,D);

%% ========= CALCOLO DELLA TRANSFER FUNCTION ====================
G = tf(sys);

%% ========== VISUALIZZAZIONE DELLA TRANSFER FUNCTION ===========
zpk(G)