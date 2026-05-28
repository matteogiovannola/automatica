

s = tf('s');
s = -(s+6.795)*(s+0.1428)*(s+9.7382);
rlocus(s*G);
T = feedback(0.7*s*G, 1);
figure
step(T);