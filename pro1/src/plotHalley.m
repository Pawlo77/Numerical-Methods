function plotHalley(F, a, x0, xmin, xmax, x_step, tolerance, max_iterations, save_path)
    % Plots F and Halley's method next approximations for F's root

    % F: function of one parameter x that returns [F(x), F'(x), F''(x)]
    % a: constants for W_n
    % x0: starting approximation
    % xmin, xmax: plot x-axis limits
    % x_step: step for generating x-axis
    % tolerance: convergence tolerance
    % max_iterations: maximum number of iterations
    % save_path: path to save the figure (optional)

    % Generate x values for the plot
    x = xmin:x_step:xmax;

    % Compute Halley's method approximations
    root = halley(F, x0, tolerance, max_iterations);
    iter_num = length(root) - 1;
    n = length(a) - 1;
    x1 = root(length(root));

    % Evaluate the function F(x) for the plot
    [Fx, Fdx, Fddx] = F(x);

    % Plot
    fig = figure('Position', [100, 100, 800, 600]);
    plot(x, Fx, 'LineWidth', 2);
    xlabel("x");
    ylabel("y = W_" + n + "(x)");
    title_handle = title("Approximation of W_" + n + "(x) for starting approximation " + x0);
    set(title_handle, 'FontSize', 16);
    subtitle("Zero point: " + x1 + ", Iteration number: " + iter_num + ", Tolerance: " + tolerance);
    hold on;
    plot(root, F(root), 'o', 'MarkerSize', 8, 'MarkerFaceColor', 'r', 'MarkerEdgeColor', 'r');
    legend("W_" + n + "(x)", "Halley's method approximations", 'Location', 'Best');
    grid on;
    axis tight;

    % Save the figure if save_path is provided
    if nargin > 8 && ~isempty(save_path)
        saveas(gcf, save_path, 'png');
        close(fig);
    end
end
