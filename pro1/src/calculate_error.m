function e = calculate_error(real, pred)
    % calculates relative error between real and pred
    e = (pred - real) / real;
end