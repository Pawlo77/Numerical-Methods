function [W, Z] = pochodnaTable(f, x, val, n, pd, pp)
% pochodnaTable liczy wartosc pochodnej f po argumencie x o wartosci 
% x_val - zwraca dla kazdego x_val wiersz macierz o length(n) wierszach 
% postaci (n, przyblizona wartosc pochodnej, dokladna wartosc pochodnej)
    user_val = val;
    val = pi / 6;

    W = zeros(length(val), length(n), 3);
    W(:, :, 1) = repmat(n, length(val), 1);
    W(:, :, 2) = repmat(pd(f, x, val).', 1, length(n));
    W(:, :, 3) = pp(f, x, val, n).';
    W = squeeze(W(1, :, :));
    W = array2table(W, "VariableNames", ["N", "dokladna pochodna", "przyblizona pochodna"]);

    val = user_val;
    n = -12;
    Z = zeros(length(val), length(n), 3);
    Z(:, :, 1) = repmat(n, length(val), 1);
    Z(:, :, 2) = repmat(pd(f, x, val).', 1, length(n));
    Z(:, :, 3) = pp(f, x, val, n).';
   
end