function [] = plot_uncorrelated( A, num_samples, name )
    % Creates corelated random variables plots based on A
    % 
    % A: square, positive-defined matrix
    % name: plot name to be saved to

    n = length(A(1, :));
    L = cholesky_decomposition(A, true);

    uncorrelatedData = randn(n, num_samples);
    correlatedData = L * uncorrelatedData;
    
    figure('visible', 'off');

    subplot(2, 2, 1);
    scatter3(uncorrelatedData(1, :), uncorrelatedData(2, :), uncorrelatedData(3, :), 'r.');
    title('Uncorrelated Random Variables');
    xlabel('X');
    ylabel('Y');
    zlabel('Z');
    
    subplot(2, 2, 2);
    scatter3(correlatedData(1, :), correlatedData(2, :), correlatedData(3, :), 'b.');
    title('Correlated Random Variables');
    xlabel('X');
    ylabel('Y');
    zlabel('Z');
    
    subplot(2, 2, 3);
    
    hist3(uncorrelatedData(1:2, :)', [20, 20]);
    title('Uncorrelated Data Distribution');
    xlabel('X');
    ylabel('Y');
    zlabel('Frequency');
    
    subplot(2, 2, 4);
    hist3(correlatedData(1:2, :)', [20, 20]);
    title('Correlated Data Distribution');
    xlabel('X');
    ylabel('Y');
    zlabel('Frequency');
    
    sgtitle('Cholesky Decomposition for Correlated Random Variables');
    saveas(gcf, './../images/' + name + '.png')
end