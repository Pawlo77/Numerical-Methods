function [d, s] = rozklad(a, b)
    % Sprawdź poprawność danych wejściowych
    if ~isequal(size(a), size(b) + [0, 1])
        error('Wektory a musi byc o 1 dluzszy od wektora b.');
    end

    n = size(a, 2);

    % tworzymy puste wektory wynikowe
    d = zeros(1, n);
    s = zeros(1, n - 1);

    % wyliczamy zgodnie z algorytmem
    d(1) = sqrt(a(1));
    s(1) = b(1) / d(1);
    for i = 2:(n - 1)
        d(i) = sqrt(a(i) - s(i - 1) ^ 2);
        s(i) = b(i) / d(i);
    end
    d(n) = sqrt(a(n) - s(n - 1) ^ 2);
end
