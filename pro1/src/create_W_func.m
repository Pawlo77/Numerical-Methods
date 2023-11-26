function W_func = create_W_func(a)
    % Creates W_n function according to halley function requirements,
    % so the function of just one parameter x that returns W_n(x), W'_n(x), W''_n(x)
    W_func = @(x) W(a, length(a) - 1, x);
end