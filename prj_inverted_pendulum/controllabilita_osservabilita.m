%% ========== CONTROLLABILITA': IL SISTEMA E' COMPLETAMENTRE CONTROLLABILE? ===========
x1 = rank(ctrb(A,B));
fprintf("Controllabilita': %d ", x1);

if x1 == size(A) 
    fprintf("=> sistema tutto controllabile\n");
else
    fprintf("=> sistema non tutto controllabile\n");
end

%% ========== OSSERVABILITA': IL SISTEMA E' COMPLETAMENTRE OSSERVABILE? ===============
x2 = rank(obsv(A,C));
fprintf("Osservabilita': %d ", x2);

if x2 == size(A) 
    fprintf("=> sistema tutto controllabile\n");
else
    fprintf("=> sistema non tutto osservabile\n");
end

