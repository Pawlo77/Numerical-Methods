function A = generate_matrix(n)
    % Generates matrix A that meets task condition
    % 
    % n - positive natural number dividable by 2

    %%%%%%%%%%%%%%%%%% parameter check
    if nargin ~= 1
        error('Wrong argument number!');
    end
    if n < 2 || mod(n, 2) == 1
        error('Wrong n!');
    end
    %%%%%%%%%%%%%%%%%%

    p = n / 2;

    A1 = generate_SPD_matrix(p);
    A2 = generate_SPD_matrix(p);
    A3 = rand(p, p);

    A = [A1, A3; A3', -A2];

end