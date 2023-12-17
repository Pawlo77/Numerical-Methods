format long;
rng(42);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% example 1

% define A and b
% utility function that creates 6x6, symetric positive-defined matrix
A = generate_matrix(6);
b = rand(6, 1);

% solve project using 
[L, D, x] = solve_project(A, b, true);

fprintf("\nMatrix A:\n");
disp(A);
fprintf("Vector b:\n");
disp(b);
fprintf("Solution vector b:\n");
disp(x);
fprintf("Matrix L:\n");
disp(L);
fprintf("Matrix D:\n");
disp(D);

plot_relative_error(b, A * x, 10e12, "'Relative error (* 10e12)'", "example1");

A = [ones(5) + 10 * eye(5), ones(5); ones(5), -(ones(5) + 10 * eye(5))];
b = rand(10, 1);
% solve project using 
[L, D, x] = solve_project(A, b, true);
plot_relative_error(b, A * x, 10e12, "'Relative error (* 10e12)'", "example1_1");

fprintf("Vector b:\n");
disp(b);
fprintf("Solution A * x:\n");
disp(A * x);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% example 2

size = 10e1:10e1:10e2;
times = zeros(1, length(size));
for i = 1:length(size)
    % A = generate_matrix(size(i));
    A = ones(size(i)) + eye(size(i));
    b = rand(size(i), 1);

    tic;
    [L, D, x] = solve_project(A, b);
    times(i) = toc;
end

time_per_size = times ./ (size .^ 2);
T = table(times', time_per_size', 'VariableNames', ["execution time", "per_size"] );
T = rows2vars(T);
T.Properties.VariableNames = ["Size", size(:)'];
fprintf("\nTime comprahsion for matrixes nxn defined as ones(n) + eye(n):\n");
disp(T);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% example 3

size = ones(1, 10) * 1000;
times = zeros(1, length(size));
names = string.empty;
for i = 1:length(size)
    A = generate_matrix(size(i));
    b = rand(size(i), 1);

    tic;
    [L, D, x] = solve_project(A, b);
    times(i) = toc;
    names(i) = string(size(i)) + "_" + string(i);
end

time_per_size = times ./ (size .^ 2);
T = table(times', time_per_size', 'VariableNames', ["execution time", "per_size"] );
T = rows2vars(T);
T.Properties.VariableNames = ["Size", names(:)'];
fprintf("\nTime comprahsion for matrixes nxn (random values from 0 to 1 times 10e20):\n");
disp(T);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% example 4

size = 10e1:10e1:10e2;
times = zeros(1, length(size));
for i = 1:length(size)
    A = generate_matrix(size(i)) * 10e20;
    b = rand(size(i), 1);

    tic;
    [L, D, x] = solve_project(A, b);
    times(i) = toc;
end

time_per_size = times ./ (size .^ 2);
T = table(times', time_per_size', 'VariableNames', ["execution time", "per_size"] );
T = rows2vars(T);
T.Properties.VariableNames = ["Size", size(:)'];
fprintf("\nTime comprahsion for matrixes nxn defined as (ones(n) + eye(n)) * 10e10:\n");
disp(T);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% example 5

size = [10e1, 10e2, 10e3];
times = zeros(1, length(size));
times2 = zeros(1, length(size));
times3 = zeros(1, length(size));
diffs = zeros(1, length(size));
for i = 1:length(size)
    A = generate_matrix(size(i)) * 10e20;
    b = rand(size(i), 1);

    tic;
    [L, D, x] = solve_project(A, b);
    times(i) = toc;
    tic;
    x2 = A \ b;
    times2(i) = toc;
    times3(i) = times(i) - times2(i);
    diffs(i) = sum(x - x2);
end

time_per_size = times ./ (size .^ 2);
T = table(times', times2', times3', diffs', 'VariableNames', ["execution time cholesky", "execution time matlab", "execution time difference (chol - mat)", "difference - sum(x1 - x2)"] );
T = rows2vars(T);
T.Properties.VariableNames = ["Size", size(:)'];
fprintf("\nSpeed comprahsion:\n");
disp(T);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% example 6

A = generate_SPD_matrix(1000);
plot_uncorrelated(A, 1000, "random_matrix");

A = [4, 2, -2; 2, 5, -4; -2, -4, 6];
plot_uncorrelated(A, 500, "my_matrix");
