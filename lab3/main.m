syms x;

val = linspace(0, 2*pi);
n = [-2, -6, -10, -15, -20];
f = 2 * cos(x/2);

[W, Z] = pochodnaTable(f, x, val, n, @pochodnaD, @pochodnaP);
W

pochodnaWykres(f, x, val, n, @pochodnaD, @pochodnaP);