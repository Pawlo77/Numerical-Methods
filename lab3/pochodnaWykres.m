function [] = pochodnaWykres(f, x, val, n, pd, pp)
% pochodnaWykres robi wykres :)
    y1 = vpa(subs(f, x, val));
    y2 = pd(f, x, val);

    figure
    subplot(2, 2, 1)
    plot(val, y1, 'r')
    title('Wykres 1')
    legend(string(f))
    xlabel('x'), ylabel('y')
    
    subplot(2, 2, 3)
    hold on;
    plot(val, y2, 'r')
    title('Wykres 2')
    legend(string(diff(f)))
    xlabel('x'), ylabel('y')

    % na tych wartosciach n faktycznie widac ze te linie sie nie pokrywaja
    % n = [-0.1, -0.3, -0.7, -1, -10]
    subplot(2, 2, [2,4])
    hold on;
    color = ['y', 'm', 'c', 'r', 'g'];
    y3 = pp(f, x, val, n);
    for i = 1:5
        plot(val, y3(i,:), color(i))
    end
    title('Wykres 3')
    legend(strcat("n=", string(n(1:5))))
    xlabel('x'), ylabel('y')
 
end