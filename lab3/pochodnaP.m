function [W] = pochodnaP(f, x, val, n)
% pochodnaP dla kazdej wartosci val zwraca wektor o length(n)
% przyblizonych wartosciach pochodnej f po x dla wartosci val
% W zawiera wyniki sklejone kolumnami
    W = zeros(length(val), length(n), 2);
    h = 2 .^ n;

    val_and_h = repmat(val, length(h), 1) + repmat(h.', 1, length(x));
    val_minus_h = repmat(val, length(h), 1) - repmat(h.', 1, length(x));
    two_h = repmat((2 * h).', 1, length(x));
    W = (vpa(subs(f, x, val_and_h)) -  vpa(subs(f, x, val_minus_h))) ./ two_h;
end