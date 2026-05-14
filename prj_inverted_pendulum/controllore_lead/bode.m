k = -30;
bode(k*G);
grid on;

[Gm,Pm,Wcg,Wcp] = margin(k*G);
fprintf('Phase margin = %g deg, frequenza di taglio: %g\n', Pm, Wcp);

%% ========= PARAMETRI =============
T = 0.255;
a = 0.1;
s = tf('s');

%% ========= CONTROLLORE ============
controllore = k * (1+T*s)/(1+a*T*s);

%% =========== NUOVO BODE ==========
bode(controllore*G);
grid on;

%% =============== POLI ==============
sys_cl = feedback(controllore * G, 1);
poles = pole(sys_cl);
disp(poles);

%% ======== NYQUIST ========
nyquist(controllore*G);


