%% ========== CONTROLLABILITA': IL SISTEMA E' COMPLETAMENTRE CONTROLLABILE? ===========
x1 = rank(ctrb(A,B));
fprintf("Controllabilita': %d\n", x1);

%% ========== OSSERVABILITA': IL SISTEMA E' COMPLETAMENTRE OSSERVABILE? ===============
x2 = rank(obsv(A,C));
fprintf("Osservabilita': %d\n", x2);