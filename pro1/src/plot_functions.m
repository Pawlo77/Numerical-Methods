function plot_functions(x, range, title_, save_path) 
    % An utility function to plot a function Fx in values x
    
    fig = figure('Position', [100, 100, 800, 600]);
    xlabel("x");
    ylabel("W_n(x)");
    title_handle = title(title_);
    set(title_handle, 'FontSize', 10);
    grid on;
    axis tight;
    hold on;
    for i = range
        Wn = create_W_func(ones(1, i));
        plot(x, Wn(x), 'LineWidth', 2);
    end
    legend(string(range));

    % Save the figure if save_path is provided
    if nargin > 3 && ~isempty(save_path)
        saveas(gcf, save_path, 'png');
        close(fig);
    end
end