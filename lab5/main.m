% Przykładowe dane wejściowe
a = [1, 5, 5, 5];
b = [2, 2, 2];

tic;
[d, s] = rozklad(a, b);
czas_wykonania = toc;

fprintf('Czas wykonania funkcji wyniósł %.4f sekundy\n', czas_wykonania);

% wyniki
disp('Wektor d:');
disp(d);
disp('Wektor s:');
disp(s);
