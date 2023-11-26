function lengths = count_iters(F, appr, tolerance, max_iter)
    % Counts number of iterations for each starting approximation 

    % F: function of one parameter x that returns [F(x), F'(x), F''(x)]
    % appr: vector of starting approximation
    % tolerance: convergence tolerance
    % max_iterations: maximum number of iterations
    lengths = zeros(1, length(appr));
    i = 1;
    for x = appr
        try
            root = halley(F, x, tolerance, max_iter);
            lengths(i) = length(root) - 1;
        catch ME
            lengths(i) = -1;
        end
        i = i + 1;
    end
end

