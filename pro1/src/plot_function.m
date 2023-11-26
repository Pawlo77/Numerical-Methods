function plot_function(x, Fx, title_, save_path) 
    % An utility function to plot a function Fx in values x
    
    fig = figure('Position', [100, 100, 800, 600]);
    plot(x, Fx, 'LineWidth', 2);
    xlabel("x");
    ylabel("W_n(x)");
    title_handle = title(title_);
    set(title_handle, 'FontSize', 10);
    grid on;
    axis tight;

    % Save the figure if save_path is provided
    if nargin > 3 && ~isempty(save_path)
        saveas(gcf, save_path, 'png');
        close(fig);
    end
end