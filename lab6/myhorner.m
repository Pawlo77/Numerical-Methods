function v = myhorner(c,x,t)
% c - wektor współczynników postaci Newtona
% x - wektor węzłów
% t - wektor argumentów
% v - wartość wielomianu w punktach t
n = length(c);

v = c(n);
for i=(n-1):-1:1
    v = v .* (t - x(i)) + c(i);

end