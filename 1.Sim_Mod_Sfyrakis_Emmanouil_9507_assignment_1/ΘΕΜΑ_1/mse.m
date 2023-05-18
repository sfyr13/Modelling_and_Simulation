function theta_0 = mse(y, zita, dim)

    sum1 = 0;
    sum2 = 0;

    N = length(y);

    for i = 1:N
        sum1 = sum1 + zita(:, i) * zita(:, i)';
        sum2 = sum2 + zita(:, i) * y(i, dim);
    end

    sum1 = sum1 / N;
    sum2 = sum2 / N;
    
    theta_0 = sum1 \ sum2;
    
end