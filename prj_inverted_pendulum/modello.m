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

C = [1 0 l 0]; 

D = 0;

%% ========= CREAZIONE DEL SISTEMA IN SPAZIO DI STATO ===========
sys = ss(A,B,C,D);

%% ========= CALCOLO DELLA TRANSFER FUNCTION ====================
G = tf(sys);

zpk(G)  % Visualizzazione tf


%% ========== CONTROLLABILITA' E OSSERVABILITA' ===========
x1 = rank(ctrb(A,B));
fprintf("Controllabilita': %d ", x1);

if x1 == size(A) 
    fprintf("=> sistema tutto controllabile\n");
else
    fprintf("=> sistema non tutto controllabile\n");
end

x2 = rank(obsv(A,C));
fprintf("Osservabilita': %d ", x2);

if x2 == size(A) 
    fprintf("=> sistema tutto controllabile\n");
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






