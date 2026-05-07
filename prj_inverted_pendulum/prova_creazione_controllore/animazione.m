
%% ============= DEFINIZIONE DEL SISTEMA IN SPAZIO DI STATO ===============
sys_cl = ss(Acl,B,C,D);

%% ====================== CONDIZIONI INIZIALI =============================
x0 = [0 0 -0.2 0];

%% =================================== TEMPO ==============================
t = 0:0.01:10;

%% ============================ INIZIO SIMULAZIONE ========================
[~,~,x] = initial(sys_cl,x0,t);

%% ================================== GRAFICO =============================
figure;
axis equal;
grid on;
hold on;

xlim([-1 1]);
ylim([-0.5 0.5]);

title('Pendolo Inverso - Animazione');

% inizializzazione oggetti
carrello = rectangle('Position',[0 -0.05 0.2 0.1],'FaceColor','b');
asta = plot([0 0],[0 0],'k','LineWidth',2);
massa = plot(0,0,'ro','MarkerSize',10,'MarkerFaceColor','r');

for k = 1:length(t)

    xc = x(k,1);      % posizione carrello
    theta = x(k,3);   % angolo pendolo

    % posizione massa pendolo
    xp = xc + l*sin(theta);
    yp = l*cos(theta);

    % aggiorna carrello
    carrello.Position = [xc-0.1 -0.05 0.2 0.1];

    % aggiorna asta
    set(asta,'XData',[xc xp],'YData',[0.05 yp]);

    % aggiorna massa
    set(massa,'XData',xp,'YData',yp);

    drawnow;

end