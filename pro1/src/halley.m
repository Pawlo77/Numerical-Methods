function root = halley(F, x0, tolerance, max_iterations)
    % Halley's method for finding a root of the function F
    % it will be the last element of root return variable
    % earlier entries are how x values in (i-1)th iteration
    % F: function of one parameter x that returns [F(x), F'(x), F''(x)]
    % x0: starting approximation
    % tolerance: convergence tolerance
    % max_iterations: maximum number of iterations

    root = zeros(1, max_iterations);
    root(1) = x0;
    [Fx, Fdx, Fddx] = F(root(1));
    if abs(Fx) < tolerance
        root = root(1:1); % Trim unused part of the array
        return;
    end

    for i = 2:max_iterations        
        % Halley's method iteration
        root(i) = root(i-1) - (2 * Fx * Fdx) / (2 * Fdx^2 - Fx * Fddx);
        % Evaluate function and its derivatives at current x
        [Fx, Fdx, Fddx] = F(root(i));

        % Check for convergence
        if abs(root(i) - root(i-1)) < tolerance || abs(Fx) < tolerance
            root = root(1:i); % Trim unused part of the array
            return;
        end
        if isnan(root(i))
            error("Method did not coverage");
        end
    end
    
    error("Method did not coverage");
end