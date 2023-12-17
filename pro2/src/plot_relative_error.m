function [] = plot_relative_error( a, b, times, tt, name )
    % a: true vector
    % b: calculated vector
    % times: how many times to multiplate the error
    % tt: chart title
    % name: name to save to the plot (optional)

    %%%%%%%%%%%%%%%%%% parameter check
    if ~( nargin ~= 4 || nargin ~= 5 )
        error('Wrong argument number!');
    end
    if size(a) ~= size(b)
        error('a and b must be the same size');
    end
    %%%%%%%%%%%%%%%%%%

    heat_map = zeros(size(a));
    nonzero_indices = (a ~= 0);
    heat_map(nonzero_indices) = (a(nonzero_indices) - b(nonzero_indices)) ./ a(nonzero_indices) * times;
    heat_map(~nonzero_indices) = inf;
    % heat_map = rot90(heat_map);
    
    figure('visible', 'off');
    imagesc(heat_map);
    
    cmap = cool();
    cmap(length(cmap), :) = [0, 0, 0];  % Set last color to black
    colormap(cmap);
    caxis([-1, 1]);
    colorbar;
    
    set(gcf, 'Position', [100, 100, 180, 250]);
    
    xlabel('');
    ylabel('Index');
    title(tt);
    xticks([]);
    yticks(1:size(heat_map, 1));
    yticklabels(arrayfun(@(x) num2str(x), 1:size(heat_map, 1), 'UniformOutput', false));
    
    [row, col] = size(heat_map);
    for i = 1:row
        for j = 1:col
            val = heat_map(i, j);
            text(j, i, num2str(val, '%.2f'), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'Color', 'white');
        end
    end

    if nargin == 5
        saveas(gcf, './../images/' + name + '.png');
    end
end