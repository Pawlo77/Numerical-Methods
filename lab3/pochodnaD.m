function [W] = pochodnaD(f, x, val)
% pochodnaD liczy wartość pochodnej funkcji f po argumencie x
% w x=val
    fp = diff(f);
    W = vpa(subs(fp, x, val));
end