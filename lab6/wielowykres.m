function c = wielowykres(f, a, b, n)
% f - funkcja interpolowana
% a, b - końce przedziału
% n - maksymalny stopień wielomianu interpolacyjnego
x = linspace(a, b, n + 1);
y = f(x);
c = ilorazr(x, y);

x_chart = linspace(a, b, 1000);
y_chart = myhorner(c, x, x_chart);
y_chart_true = f(x_chart);

f_min = min(y_chart_true);
f_max = max(y_chart_true);

figure;
plot(x_chart, y_chart_true, 'DisplayName', 'f(x)');
hold on;
plot(x_chart, y_chart, 'r', 'DisplayName', 'Wielomian interpolacyjny f(x)');
scatter(x, y, 'k', 'filled', 'DisplayName', 'Węzły interpolacyjne');
xlim([a, b]);
ylim([2*f_min - f_max, 2*f_max - f_min]);
xlabel('x');
ylabel('y');
title('Interpolacja wielomianowa');
legend('Location', 'best');
grid on;
hold off;

end