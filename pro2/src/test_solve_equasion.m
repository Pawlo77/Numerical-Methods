function [err, rel_err] = test_solve_equasion( A, b, x1, check_params )
    % Solves system of linear equasions Ax = b
    % 
    % A: square (nxn), upper / lower triangular and positively defined matrix
    % b: vector of size n
    % x1: solution that meets A * x1 = b
    % check_params - weather to check if input array A meets its
    %                assumptions, which is computation extensive
    %                defaults to false

    n=length(A(1,:));    

    %%%%%%%%%%%%%%%%%% parameter check
    if ~( nargin >= 3 && nargin <= 4 )
        error('Wrong argument number!');
    end
    if nargin == 2
        check_params = false;
    end

    if check_params
        if length(A(:,1)) ~= n
            error('A is not a square matrix!');
        end
        if length(x1) ~= n
            error('x1 size is not n!');
        end
        if length(b) ~= n
            error('b size is not n!');
        end
    end
    %%%%%%%%%%%%%%%%%%

    if ~ all(all(abs(A * x1 - b) <= 1e-10))
        error('x1 does not meet A * x1 = b!');
    end
  
    err = sum(abs(A * x1 - b));
    c = sum(b);
    if c ~= 0
        rel_err = err / c;
    else
        rel_err = "inf";
    end
end