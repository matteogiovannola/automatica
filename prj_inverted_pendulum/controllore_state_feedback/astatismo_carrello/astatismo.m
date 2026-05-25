A_aug = [A, zeros(4,1); -C, 0];
B_aug = [B; 0];
des_aug = [complex(-4, 2), complex(-4, -2), -7, -6 -1];
K_aug = place(A_aug, B_aug, des_aug);

Acl_aug = A_aug - B_aug * K_aug;
Bcl_aug = [0; 0; 0; 0; 1]; 
Ccl_aug = [1, 0, 0, 0, 0]; 
Dcl_aug = 0;

sys_cl_aug = ss(Acl_aug, Bcl_aug, Ccl_aug, Dcl_aug);

figure
step(sys_cl_aug);


%% 
rank(ctrb(A_aug, B_aug))

C_u = -K_aug;
sys_u = ss(Acl_aug, Bcl_aug, C_u, 0);
figure
step(sys_u)