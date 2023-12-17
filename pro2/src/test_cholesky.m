function [err, rel_err] = test_cholesky( A, L, check_params )
    % Uses chol function to decompose A and checks if 
    % this decomposition is equal to L
    % 
    % A: square, simmetrical and positively defined matrix
    % L: decomposed A using cholesky decomposition
    % check_params - weather to check if input array A meets its
    %                assumptions, which is computation extensive
    %                defaults to false

    n=length(A(1,:));    

    %%%%%%%%%%%%%%%%%% parameter check
    if ~( nargin >= 2 && nargin <= 3 )
        error('Wrong argument number!');
    end
    if nargin == 2
        check_params = false;
    end

    if check_params
        if length(A(:,1)) ~= n
            error('A is not a square matrix!');
        end
        if A ~= transpose(A)
            error('A is not a symetrical matrix!');
        end
        for i=1:n
            if (det(A(1:i,1:i))<=0)
                error('A is not positive defined!');
            end
        end
    end
    %%%%%%%%%%%%%%%%%%

    L2 = chol(A);
    if ~ all(all(abs(L - L2') <= 1e-10))
        error("Wrong decomposition.");
    end

    err = sum(sum(abs(L - L2')));
    c = sum(sum(L));
    if c ~= 0
        rel_err = err / c;
    else
        rel_err = "inf";
    end
end