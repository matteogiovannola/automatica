%% =============== CONTROLLORE ===============
s = tf('s');
controllore = (s + 0.14)/s;

%% ============== SISTEMA IN CATENA DIRETTA ========
sis = minreal(controllore * G);

%% ============= LUOGO DELLE RADICI PER K<0 ==========
rlocus(-sis);
txt = evalc('zpk(sis)');
fprintf('%s\n', txt);

%% ============= SISTEMA IN RETROAZIONE: SI MOSTRANO I POLI =================
T = feedback(-8 * sis, 1);
disp(pole(T));




