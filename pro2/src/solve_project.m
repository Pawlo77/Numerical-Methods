function [L, D, x] = solve_project( A, b, check )
    % Solves system of linear equasions Ax = b where A is matrix 
    % defined in project.
    % 
    % A: block matrix [X, Y; Y^T, Z] (square (nxn)), where X and Z 
    % are symmetrical, positive defined matrixes.
    % b: vector of size n
    % check - weather to check if input data meets its assumtions
    %         and all computations are performed correctly

    n=length(A(1,:));    

    %%%%%%%%%%%%%%%%%% parameter check
    if ~( nargin >= 2 && nargin <= 3 )
        error('Wrong argument number!');
    end
    if nargin == 2
        check = false;
    end
    if n < 2 || mod(n, 2) == 1
        error('Wrong n!');
    end
    %%%%%%%%%%%%%%%%%%

    p = n / 2;
    A_11 = A(1:p, 1:p);
    A_12 = A(1:p, (p + 1):n);
    A_22 = -A((p + 1):n, (p + 1): n);

    L_11 = cholesky_decomposition(A_11, check);
    if check
        [err, rel_err] = test_cholesky(A_11, L_11, check);
        fprintf("Error in calculating L_11: %.20f (relative %.20f) \n", err, rel_err);
    end

    L_21_T = L_11^(-1) * A_12;
    L_21 = L_21_T';

    K = L_21 * L_21_T + A_22;
    L_22 = cholesky_decomposition(K, check);
    if check
        [err, rel_err] = test_cholesky(K, L_22, check);
        fprintf("Error in calculating L_22: %.20f (relative %.20f) \n", err, rel_err);
    end

    L = [L_11, zeros(p, p); L_21, L_22];
    D = [eye(p), zeros(p, p); zeros(p, p), -eye(p)];

    y = solve_equasion(L, b, "lower", check);
    if check
        test_solve_equasion(L, b, y, check);
    end
    
    x = solve_equasion(D * L', y, "upper", check);
    if check
        test_solve_equasion(D * L', y, x, check);
        [err, rel_err] = test_solve_equasion(A, b, x, check);
        fprintf("Error in solving equasion: %.20f (relative %.20f) \n", err, rel_err);
    end

end