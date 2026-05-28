L0 = -G;

%% ============== PARAMETRI CONTROLLORE ===================================
z = 14;        % zero della rete lead
p = 145;       % polo della rete lead (molto piu' a sinistra dello zero)
K = 100;       % guadagno


s = tf('s');
C_ctrl = K * (s + 6.7953) * (s + 0.1428) * (s + z) / (s + p); % Cancello i poli stabili

disp('--- Controllore C(s) ---');
C_ctrl

%% =================== ANELLO CHIUSO ======================================
L = C_ctrl * L0;     
T = feedback(L, 1);       % Anello chiuso (retroazione unitaria)

disp('--- Poli ad ANELLO CHIUSO ---');
poli_cl = pole(T);
disp(poli_cl);

if all(real(poli_cl) < 0)
    fprintf('==> ANELLO CHIUSO STABILE\n\n');
else
    fprintf('==> ANELLO CHIUSO INSTABILE (rivedere z,p,K)\n\n');
end

%% ===================== VERIFICA DI NYQUIST ==============================
figure;
nyquist(L); grid on;
title('Nyquist');

% Margini (per sistema instabile il "margine di guadagno" e' una SOGLIA MINIMA: servono guadagni SOPRA un certo valore, non sotto)
[Gm, Pm, Wcg, Wcp] = margin(L);
fprintf('Margine di guadagno (soglia, sist. instabile): %.3g\n', Gm);
fprintf('Margine di fase: %.3g deg @ %.3g rad/s\n\n', Pm, Wcp);

%% ==================================== BODE ==============================
figure; bode(L); grid on; title('Bode');

%% ====================== RISPOSTA AL GRADINO =============================
figure; step(T); grid on;
title('Risposta al gradino dell''anello chiuso');

%% ==================== FUNZIONE DI SENSITIVITA' ==========================
S = feedback(1, L);       
figure; bode(S); grid on;
title('Sensitivita');
