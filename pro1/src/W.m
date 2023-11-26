function [Wx, Wdx, Wddx] = W(a, n, x)
    % calculates value of a function W given in task at points x, 
    % its first and second derevative
  
    % a: vector coefficients of the chebyshev polynomial (a_0, a_1, ..., a_n)
    % n: degree of the chebyshev polynomial
    % x: vector of points where the function should be evaluated
    
    % chebyshev polynomial
    % T = @(k, x) real(cos(k * acos(x)));
    
    % to avoid computing the same values twice
    tx = zeros(length(x), n + 1); % for F
    tdx= zeros(length(x), n + 1); % for F'
    tddx= zeros(length(x), n + 1); % for F''
    
    % starting condions
    tx(:, 1) = 1;
    tx(:, 2) = x;
    %tdx(:, 1) = 0;
    tdx(:, 2) = 1;
    %tddx(:, 1) = 0;
    %tddx(:, 2) = 0;

    % using recursive property of chebyshev polynomial
    for i = 2:n
       tx(:, i + 1) = 2 * x' .* tx(:, i) - tx(:, i - 1);
       tdx(:, i + 1) = 2 * tx(:, i) + 2 * x' .* tdx(:, i) - tdx(:, i - 1);
       tddx(:, i + 1) = 4 * tdx(:, i) + 2 * x' .* tddx(:, i) - tddx(:, i - 1);
    end
    
    Wx = sum(tx .* flip(tx, 2) .* a, 2)';
    Wdx = sum(a .* (tdx .* flip(tx, 2) + tx .* flip(tdx, 2)), 2)';
    Wddx = sum(a .* (tddx .* flip(tx, 2) + 2 * tdx .* flip(tdx, 2) + tx .* flip(tddx, 2)), 2)';
end
    