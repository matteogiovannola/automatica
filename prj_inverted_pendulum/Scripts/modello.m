%% ========== DEFINIZIONE PARAMETRI ================
g = 9.81;
m = 0.2;
M = 0.5;
b = 0.1;
l = 0.3;

%% ========== CREAZIONE MATRICI ====================
A = [0 1 0 0;
    0 -b/M -m*g/M 0;
    0 0 0 1;
    0 b/(M*l) (M+m)*g/(M*l) 0];

B = [0; 1/M; 0; -1/(M*l)];

C = [1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1];

C_x = [1 0 0 0];  % Uscita sulla posizione del carrello
C_theta = [0 0 1 0];  % Uscita sull'angolo del pendolo
C_lin = [1 0 l 0];  % Uscita sulla posizione orizzontale linearizzata del pendolo

D = 0;

%% ========= CREAZIONE DEL SISTEMA IN SPAZIO DI STATO ===========
sys_x = ss(A, B, C_x, D);
sys_theta = ss(A, B, C_theta, D);
sys_lin = ss(A, B, C_lin, D);

%% ========= CALCOLO DELLE TRANSFER FUNCTION ====================
G_x = tf(sys_x);
zpk(G_x)  % Visualizzazione tf per la posizione

G_theta = tf(sys_theta);
zpk(G_theta)  % Visualizzazione tf per l'angolo

G_lin = tf(sys_lin);
zpk(G_lin)  % Visualizzazione tf per la posizione linearizzata del pendolo


%% ========== CONTROLLABILITA' E OSSERVABILITA' ===========
contr = rank(ctrb(A,B));
fprintf("Controllabilita': %d ", contr);

if contr == size(A) 
    fprintf("=> sistema tutto controllabile\n");
else
    fprintf("=> sistema non tutto controllabile\n");
end

% Osservabilità con uscita la posizione del carrello
oss_x = rank(obsv(A, C_x));
fprintf("Osservabilita' (posizione carrello): %d ", oss_x);

if oss_x == size(A) 
    fprintf("=> sistema tutto osservabile\n");
else
    fprintf("=> sistema non tutto osservabile\n");
end

% Osservabilità con uscita l'angolo del pendolo
oss_theta = rank(obsv(A, C_theta));
fprintf("Osservabilita' (angolo pendolo): %d ", oss_theta);

if oss_theta == size(A) 
    fprintf("=> sistema tutto osservabile\n");
else
    fprintf("=> sistema non tutto osservabile\n");
end

% Osservabilità con uscita la posizione linearizzata del pendolo
oss_lin = rank(obsv(A, C_lin));
fprintf("Osservabilita' (posizione linearizzata pendolo): %d ", oss_lin);

if oss_lin == size(A) 
    fprintf("=> sistema tutto osservabile\n");
else
    fprintf("=> sistema non tutto osservabile\n");
end

%% ===================== STABILITA' ============================
fprintf("Autovalori di A: \n");
autovalori = eig(A);
disp(autovalori);

if all(real(autovalori) < 0)
    fprintf("\nSistema stabile internamente");
else
    fprintf("\nSistema instabile internamente");
end

%% ====================== BODE E NYQUIST ==================================
% Posizione carrello
figure
bode(G_x); grid on;

figure
nyquist(G_x); grid on; 

% Angolo pendolo
figure
bode(G_theta); grid on;

figure
nyquist(G_theta); grid on; 

figure
rlocus(G_theta); grid on;

% Posizione linearizzata pendolo
figure
bode(G_lin); grid on;

figure
nyquist(G_lin); grid on; 

figure
rlocus(G_lin); grid on;






