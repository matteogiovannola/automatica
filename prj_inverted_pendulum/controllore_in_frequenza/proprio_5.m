L0 = -G;                          % funzione d'anello (segno fisico)
s  = tf('s');

%% ---------- 2) SPECIFICHE -------------------------------------------
% Smorzamento desiderato zeta = 0.75 (coerente col progetto state-feedback)
% Regola pratica:  PM[deg] ~ 100*zeta  ->  PM_target ~ 65..70 deg
zeta = 0.75;
PM_target = 65;            % [deg]

%% ---------- 3) PERCHE' SERVE L'ANTICIPO DI FASE ---------------------
% Si neutralizzano i due poli STABILI (-6.795 e -0.143) con due zeri del
% controllore. Resta il NUCLEO difficile:  Lcore = 65.4 / [ s (s-6.738) ]
% cioe' integratore + polo instabile.
%
% Al crossover desiderato la fase del nucleo (ramo corretto per polo
% instabile) e' MOLTO sotto -180 deg: il PM "naturale" e' NEGATIVO
% (sistema instabile). L'anticipo di fase phi che serve e':
%
%        phi = PM_target - (180 + fase_nucleo(wc))
%
% Per wc tra 10 e 20 rad/s risulta phi ~ 90..105 deg.
% Poiche' UNA lead da' al massimo ~90 deg (e in pratica <70 deg in modo
% sano), servono PIU' reti lead in serie. Qui ne usiamo TRE.

%% ---------- 4) DIMENSIONAMENTO ANALITICO DELLE LEAD -----------------
% Centriamo il progetto a wc_design = 35 rad/s con anticipo totale 150 deg
% (sovradimensionato perche' le lead spostano il crossover verso sinistra,
%  che si assestera' a ~10 rad/s: e' il valore "effettivo").
wc_design = 35;            % [rad/s]
phi_tot   = 150;           % anticipo totale [deg]
n_lead    = 3;             % numero di reti lead

phi_each = phi_tot/n_lead;             % anticipo per singola lead [deg]
phi      = deg2rad(phi_each);

% Rapporto polo/zero della lead dalla fase massima:
%   alpha = (1 - sin phi) / (1 + sin phi)
alpha = (1 - sin(phi)) / (1 + sin(phi));

% La fase massima cade nel centro geometrico wc_design:
%   zero = wc*sqrt(alpha) ,  polo = wc/sqrt(alpha)
z_lead = wc_design*sqrt(alpha);
p_lead = wc_design/sqrt(alpha);

fprintf('--- Dimensionamento lead ---\n');
fprintf('phi per lead = %.1f deg\n', phi_each);
fprintf('alpha = %.4f   (p/z = %.2f)\n', alpha, p_lead/z_lead);
fprintf('zero lead = %.3f rad/s\n', z_lead);
fprintf('polo lead = %.3f rad/s\n\n', p_lead);

%% ---------- 5) COSTRUZIONE DEL CONTROLLORE (PROPRIO) ----------------
% C = K * (s+6.795)(s+0.143) * [(s+z_lead)/(s+p_lead)]^3 / (s+pHF)^2
%   - (s+6.795)(s+0.143): neutralizzano i poli stabili
%   - [(s+z)/(s+p)]^3   : le tre reti lead (anticipo di fase)
%   - (s+pHF)^2         : due poli in alta frequenza per rendere C PROPRIO
pHF = 400;                                  % poli HF [rad/s]
lead = ((s + z_lead)/(s + p_lead))^n_lead;
C_noK = (s+6.7953)*(s+0.1428) * lead / (s+pHF)^2;

% Guadagno K per imporre |L(jwc_design)| = 1 (0 dB) a wc_design
K = 1/abs(evalfr(C_noK*L0, 1j*wc_design));

C_ctrl = K * C_noK;

fprintf('--- Controllore C(s) ---\n');
C_ctrl
fprintf('K = %.4e\n', K);
fprintf('Eccesso poli-zeri di C: %d  (>=0 => PROPRIO)\n\n', ...
        length(pole(C_ctrl)) - length(zero(C_ctrl)));

%% ---------- 6) ANELLO CHIUSO E VERIFICHE ---------------------------
L = C_ctrl * L0;
T = feedback(L, 1);

poli_cl = pole(T);
disp('--- Poli ad anello chiuso ---'); disp(poli_cl);
if all(real(poli_cl) < 0)
    fprintf('==> ANELLO CHIUSO STABILE\n');
else
    fprintf('==> INSTABILE\n');
end

[Gm, Pm, Wcg, Wcp] = margin(L);
fprintf('Margine di fase: %.1f deg @ %.2f rad/s (crossover effettivo)\n\n', Pm, Wcp);

%% ---------- 7) GRAFICI ---------------------------------------------
% Nyquist: deve accerchiare -1 UNA volta in senso ANTIORARIO (N=-1, P=1)
figure; nyquist(L); grid on;
title('Nyquist L=C\cdotL_0 : un giro ANTIORARIO attorno a -1');

figure; bode(L); grid on; title('Bode di L(s)');
figure; step(T); grid on; title('Risposta al gradino - anello chiuso');

S = feedback(1, L);     % sensitivity per la reiezione disturbi
figure; bode(S); grid on; title('Sensitivity S=1/(1+L)');
