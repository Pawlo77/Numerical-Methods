function A = generate_SPD_matrix(n)
    % Generates a n x n symmetric, positive definite matrix A
    % refer to https://math.stackexchange.com/questions/357980/how-to-generate-random-symmetric-positive-definite-matrices-using-matlab

    A = rand(n, n);
    A = A * A';
    A = A + 10^(-10) * eye(n);

end