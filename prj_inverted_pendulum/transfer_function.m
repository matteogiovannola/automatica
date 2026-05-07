%% ========= CREAZIONE DEL SISTEMA IN SPAZIO DI STATO ===========
sys = ss(A,B,C,D);

%% ========= CALCOLO DELLA TRANSFER FUNCTION ====================
G = tf(sys);

%% ========== VISUALIZZAZIONE DELLA TRANSFER FUNCTION ===========
for i = 1:4
    fprintf('\nTF output %d\n',i)
    zpk(G(i))
end