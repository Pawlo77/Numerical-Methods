function x = solve_equasion( A, b, opt, check_params )
    % Solves system of linear equasions Ax = b
    % 
    % A: square (nxn), upper triangular and positively defined matrix
    % b: vector of size n
    % opt - "upper" or "lower", defines A
    % check_params - weather to check if input array A meets its
    %                assumptions, which is computation extensive
    %                defaults to false

    n=length(A(1,:));    

    %%%%%%%%%%%%%%%%%% parameter check
    if ~( nargin >= 3 && nargin <= 4 )
        error('Wrong argument number!');
    end
    if nargin == 3
        check_params = false;
    end

    if check_params
        if length(A(:,1)) ~= n
            error('A is not a square matrix!');
        end
        if ~((~istril(A) && opt == "upper") || (istril(A) && opt == "lower"))
            error('A is not correct triangular matrix!');
        end
        for i=1:n
            if (A(i, i) == 0)
                error('A has 0 on main diagonal!');
            end
        end
        if length(b) ~= n
            error('b size is not n!');
        end
    end
    %%%%%%%%%%%%%%%%%%

    x = zeros(n, 1);
    if opt == "upper"
        x(n) = b(n) / A(n, n);
        for k = (n-1):(-1):1
            s = b(k) - A(k, (k+1):n) * x((k+1):n);
            x(k) = s / A(k, k);
        end
    else
        x(1) = b(1) / A(1, 1);
        for k = 2:n
            s = b(k) - A(k, 1:(k-1)) * x(1:(k-1));
            x(k) = s / A(k, k);
        end
    end

end