%% ===================== SEMPLIFICO POLI STABILI ==========================
s = tf('s');
F = 65.4 / (s * (s - 6.738));        % Segno negativo

%% ====================== BODE E NYQUIST =================================
bode(F);    grid on;  figure
nyquist(F); grid on;  figure

%% ====================== ANALISI ========================================
% Aumento il guadagno per aumentare la frequenza di taglio e aumentare il
% margine di fase
k = 30;

% Progetto la 1a rete anticipatrice: la frequenza di taglio e' 44, con un
% margine di fase di -8,7 gradi. Per arrivare a un margine di fase di 70
% gradi (smorzamento 0,7 -> sovraelongazione 5%) scelgo:
%   - una prima rete con w = 1   e m = 8
%   - una seconda rete con w = 0,7 e m = 12
% (totale anticipo di fase: 70 gradi)
tau1 = 1/44;    m1 = 8;
C_ant1 = (1 + tau1*s) / (1 + (tau1/m1)*s);

tau2 = 0.7/44;  m2 = 12;
C_ant2 = (1 + tau2*s) / (1 + (tau2/m2)*s);

% Controllore totale
C = -k * C_ant1 * C_ant2 * (s + 6.738) * (s + 0.1428) ...
      / ((1 + s/1000) * (1 + s/2000) * (1 + s/2500));   % 2 poli non dominanti

%% ========================= VERIFICA ====================================
bode(C * G_lin); grid on; figure

T = feedback(C * G_lin, 1);
step(T);

disp(pole(T));

%% ========================= VERIFICA =====================================
figure
bode(C * G_lin); grid on;
T = feedback(C * G_lin, 1);
figure
step(T);