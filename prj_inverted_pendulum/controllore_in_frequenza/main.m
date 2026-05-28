s = tf('s');
c = -10*(s+2)/(s+20);
bode(c*G);
grid on;
figure
nyquist(c*G);
grid on;