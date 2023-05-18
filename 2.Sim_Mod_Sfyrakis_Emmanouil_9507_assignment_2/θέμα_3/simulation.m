function [set_time] = simulation(g1, g2)

A = [-0.5, -3; 4, -2];
B = [1; 1.4];

u = @(t)7.5*cos(3*t)+10*cos(2*t);

x0(1:10) = 0;
t_span = 0:0.01:100
N = length(t_span);

[~, x] = ode45(@(t, x) myfcn(t, x, u, g1, g2, A, B), t_span, x0);

output1 = x(:, 1);
output2 = x(:, 2);
a11_hat = x(:, 3);
a12_hat = x(:, 4);
a21_hat = x(:, 5);
a22_hat = x(:, 6);
b1_hat = x(:, 7);
b2_hat = x(:, 8);
output1_hat = x(:, 9);
output2_hat = x(:, 10);

for i = 1:N
    out_dif(i) = output1(i) - output1_hat(i) + output2(i) - output2_hat(i);
end

% percentage error
    perc_err = zeros( N, 1 );
    for i = 1: N
        perc_err(i) = sqrt(((output1( i )-output1_hat(i)) / output1(i))^2+((output2(i)-output2_hat(i)) / output2(i))^2);
    end

set_time = -1;
for i = 1: N
    if set_time < 0 && perc_err(i) < 0.05
        set_time = t_span(i);
    end
    if perc_err(i) >= 0.05
        set_time = -1;
    end
end

%plots
figure(1);
hold on;
plot(t_span, output1);
plot(t_span, output1_hat);
plot(t_span, output2);
plot(t_span, output2_hat);
hold off;
xlabel('time(s)');
title('Real and estimated outputs');
legend('$output1$', '$\hat{output1}$','$output2$' ,'$\hat{output2}$', 'interpreter', 'latex');

figure(2);
plot(t_span, out_dif);
xlabel('time(s)');
title('Difference between real and estimated outputs');

figure(3);
 hold on;
    plot( t_span, a11_hat);
    plot( t_span, a12_hat); 
    plot( t_span, a21_hat); 
    plot( t_span, a22_hat); 
    plot( t_span, b1_hat);
    plot( t_span, b2_hat);
    hold off;
xlabel('Time(s)');
title('Estimated Parameters');
legend('$\hat{a_{11}}$', '$\hat{a_{12}}$', '$\hat{a_{21}}$', '$\hat{a_{22}}$', '$\hat{b_1}$', '$\hat{b_2}$', 'interpreter', 'latex');

end