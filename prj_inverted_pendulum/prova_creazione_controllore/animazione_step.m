%% ANIMAZIONE DI PROVA, LA "VERA" E' L'ALTRA!

sys_cl = ss(Acl,B,C,D);

% tempo simulazione
t = 0:0.01:10;

% gradino di forza
u = ones(size(t));

% simulazione
[y,t,x] = lsim(sys_cl,u,t);

% =========================
% ANIMAZIONE
% =========================

figure;
axis equal;
grid on;
hold on;

xlim([-1 3]);
ylim([-0.1 0.5]);

title('Pendolo inverso - risposta al gradino');

% carrello
carrello = rectangle( ...
    'Position',[0 -0.05 0.2 0.1], ...
    'FaceColor','b');

% asta
asta = plot([0 0],[0 0], ...
    'k','LineWidth',2);

% massa
massa = plot(0,0,'ro', ...
    'MarkerSize',10, ...
    'MarkerFaceColor','r');

for k = 1:length(t)

    xc = x(k,1);
    theta = x(k,3);

    % posizione pendolo
    xp = xc + l*sin(theta);
    yp = l*cos(theta);

    % aggiorna carrello
    carrello.Position = [xc-0.1 -0.05 0.2 0.1];

    % aggiorna asta
    set(asta,'XData',[xc xp], ...
        'YData',[0 yp]);

    % aggiorna massa
    set(massa,'XData',xp, ...
        'YData',yp);

    drawnow;

end