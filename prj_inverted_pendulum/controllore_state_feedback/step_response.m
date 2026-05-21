figure;
step(sys_cl);

figure;
impulse(sys_cl);

fprintf("%g", bandwidth(Acl));
