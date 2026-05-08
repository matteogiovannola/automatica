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

C = eye(4); 

D = zeros(4,1);

