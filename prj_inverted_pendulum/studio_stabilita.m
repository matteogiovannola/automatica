fprintf("Autovalori di A: \n");
autovalori = eig(A);
disp(autovalori);

if all(real(autovalori) < 0)
    fprintf("\nSistema stabile internamente");
else
    fprintf("\nSistema instabile internamente");
end