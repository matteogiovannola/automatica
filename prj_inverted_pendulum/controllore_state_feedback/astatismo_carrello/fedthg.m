peso_posizione    = 500;    % Alzato per velocizzare il carrello
peso_velocita     = 10;
peso_angolo       = 10000;  % Alzato ulteriormente per garantire i -20dB
peso_vel_angolo   = 50;
peso_integratore  = 2000;   % ALZATO DI MOLTO: distrugge la lentezza a regime!

Q = diag([peso_posizione, peso_velocita, peso_angolo, peso_vel_angolo, peso_integratore]);

% R definisce il costo dell'azione di controllo (forza sul carrello)
R = 0.01; % Valore piccolo = controllo aggressivo, ideale per abbattere il disturbo

%% ==========================================
% 3. SINTESI DEI GUADAGNI CON LQR
%% ==========================================
% Ka contiene sia i guadagni dello stato (Kx) che dell'integratore (Ki)
[Ka, P, poli_calcolati] = lqr(A_aug, B_aug, Q, R);

Kx = Ka(1:n);
Ki = Ka(end);

disp('Poli ottimizzati calcolati da LQR:')
disp(poli_calcolati)