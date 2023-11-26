function [] = szeregLnPlot(x, Nmax) 
val = szeregLN(x, Nmax);
z = repmat(linspace(0, 1, Nmax + 1)', 1, length(x));
y = log(x + 1);

line1 = animatedline('Color', 'blue', 'LineStyle', '-', 'LineWidth', 1);
plot3(x, y, z(1, :));
hold on;
z
plot3(repmat(x, Nmax, 1), val, z(2:(Nmax + 1), :));
% length(val)
% length(z)
% plot3(repmat(x', 1, length(x)), val, z);

% for i=1:length(x)
% 
%     addpoints(line1, x(i), y(i), z(1));
%     % drawnow limitrate
%     pause(0.1)
% end

xlabel('x');
ylabel('ln(x + 1)');
zlabel('kolejne wykresy');
