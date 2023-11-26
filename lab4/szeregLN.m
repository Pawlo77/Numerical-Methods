function [Y] = szeregLN(x, Nmax)
x_mat = repmat(x, Nmax, 1);
n_mat = repmat((1:Nmax)', 1, length(x));
x_s = x_mat .^ n_mat;
x_s = x_s .* ((-1) .^ (n_mat - 1));
x_s = x_s ./ factorial(n_mat);
Y = cumsum(x_s, 1);
% Y = Y(Nmax, :);
end