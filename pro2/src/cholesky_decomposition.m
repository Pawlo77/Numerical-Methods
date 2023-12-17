function L = cholesky_decomposition( A, check_params )
    % Performs cholesky decomposition of matrix A 
    % 
    % A: square, simmetrical and positively defined matrix
    % check_params - weather to check if input array A meets its
    %                assumptions, which is computation extensive
    %                defaults to false

    n=length(A(1,:));    

    %%%%%%%%%%%%%%%%%% parameter check
    if ~( nargin == 1 || nargin == 2 )
        error('Wrong argument number!');
    end
    if nargin == 1
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

    L = zeros(n, n);
    for k = 1:n
        to_deduct = 0;
        if k > 1
            to_deduct = sum(L(k, 1:k-1).^2);
        end
    
        L(k, k) = sqrt(A(k, k) - to_deduct);
    
        L(k+1:n, k) = (A(k+1:n, k) - L(k+1:n, 1:k-1) * L(k, 1:k-1)') / L(k, k);
    end

end