%%% -----------------------------------------------------------------------
%%% Used as example execution call, therefore it's fully commented
%%% Next call's for code clarity and length won't be, thus they're pretty
%%% mach the same / self explanatory

% example 1

% define an a sequence
a = 1:10;
fprintf("\na=[" + num2str(a) + "]\n");

% Create W_n of one parameter x
W_func = create_W_func(a);

% plot W_n on range <-1, 1>, and sequence x = (x_1, ...) of next
% approximations of Haley's method for starting approximation of 0.5
% tolerance 10^-12 and maximum iteration number 10^3
plotHalley(W_func, a, 0.5, -1, 1, 0.01, 10^-12, 10^3, "./../plots/example1");

% retrieve x sequence for the same function parameters
z = halley(W_func, 0.5, 10^-12, 10^3);
% print final zero point
fprintf("Final zero point: %.20f \n", z(length(z)));

% calculate error
expected = 0.636393495191836;
error = calculate_error(expected, z(length(z)));
fprintf("Relative error: " + error + "\n");

% test if method in fact approched it with correct tolerance
assert(abs(error) < 10^-12);

%%% -----------------------------------------------------------------------
% example 2

a = tan(exp(1:5));
fprintf("\na=[" + num2str(a) + "]\n");
W_func = create_W_func(a);
plotHalley(W_func, a, -10^-10, -0.5, 0.5, 0.01, 10^-12, 10^3, "./../plots/example2");
z = halley(W_func, -10^-10, 10^-12, 10^3);
fprintf("Final zero point: %.20f \n", z(length(z)));
error = calculate_error(-0.372210564161923, z(length(z)));
fprintf("Relative error: " + error + "\n");
assert(abs(error) < 10^-12);

%%% -----------------------------------------------------------------------
% example 3

a = [1, 10, 2, -30, 20, 0, 1];
fprintf("\na=[" + num2str(a) + "]\n");
W_func = create_W_func(a);
plotHalley(W_func, a, 0.05, -1, 1, 0.01, 10^-12, 10^3, "./../plots/example3");
plot_iter_num(W_func, -5:0.1:5, 10^-12, 10^3, "./../plots/example3_iter");
z = halley(W_func, 0.5, 10^-12, 10^3);
fprintf("Final zero point: %.20f \n", z(length(z)));
error = calculate_error(0.981548363136206, z(length(z)));
fprintf("Relative error: " + error + "\n");
assert(abs(error) < 10^-12);

%%% -----------------------------------------------------------------------
% example 4

a = tan(-0.9:0.2:0.9);
W_func = create_W_func(a);
plot_function(-1:0.1:1, W_func(-1:0.1:1), "a=[" + num2str(a) + "]", "./../plots/example4");
plot_iter_num(W_func, -5:0.1:5, 10^-12, 10^3, "./../plots/example4_iter");

%%% -----------------------------------------------------------------------
% example 5

a = ones(1, 3);
W_func = create_W_func(a);
plot_function(-1:0.1:1, W_func(-1:0.1:1), "a=[" + num2str(a) + "]", "./../plots/example5");
x = [-20000:1000:-1000, -1000:100:200, 200:10:0];
plot_iter_num(W_func, x, 10^-12, 10^3, "./../plots/example5_iter");

%%% -----------------------------------------------------------------------
% example 6

plot_functions(-1:0.1:1, 1:4:20, "W_n look for a just of ones in comprahsion to n", "./../plots/example6");
a = ones(1, 1);
W_func = create_W_func(a);
x = -10^15:10^12:10^15;
plot_iter_num(W_func, x, 10^-12, 10^3, "./../plots/example6_iter");
fprintf("\nW_1(10^15): %.1f \n", W_func(10^15));
z = halley(W_func, 10^15, 10^-12, 10^3);
fprintf("Final zero point: %.20f \n", z(length(z)));
