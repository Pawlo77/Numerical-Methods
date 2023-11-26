function plot_iter_num(F, appr, tolerance, max_iter, save_path)
    % Plots number of iterations for each starting approximation 

    % F: function of one parameter x that returns [F(x), F'(x), F''(x)]
    % appr: vector of starting approximation
    % tolerance: convergence tolerance
    % max_iterations: maximum number of iterations
    % save_path: path to save the figure (optional)
    
    lengths = count_iters(F, appr, tolerance, max_iter);

    fig = figure('Position', [100, 100, 800, 600]);
    plot(appr, lengths, 'o', 'MarkerSize', 8, 'MarkerFaceColor', 'r', 'MarkerEdgeColor', 'r');
    xlabel("x");
    ylabel("iteration number");
    title_handle = title("Number of iterations in correlation to starting approximation");
    set(title_handle, 'FontSize', 16);
    subtitle("Tolerance: " + tolerance);
    grid on;
    axis tight;

    % Save the figure if save_path is provided
    if nargin > 4 && ~isempty(save_path)
        saveas(gcf, save_path, 'png');
        close(fig);
    end
end

