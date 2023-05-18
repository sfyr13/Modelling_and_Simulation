function[t_set] = simulation_1(g, am)

a = 1.5;
b = 2;
u = 3;

x0(1:6)=0;

t_span = 0:0.01:30;
N = length(t_span);

[~, x ] = ode45(@( t, x ) myfcn(t, x, u, am, g, a, b), t_span, x0);

output = x(:, 1);
theta1_hat = x(:, 2);
theta2_hat = x(:, 3);
output_hat = x(:, 6);

out_dif = zeros(N, 1);

for i = 1:N
    out_dif(i) = output(i) - output_hat(i);
end
    

a_hat = zeros(N, 1);

for i = 1: N
    a_hat( i ) = am - theta1_hat( i );
end

b_hat = theta2_hat;


% percentage error
perc_err = zeros(N, 1);
for i = 1: N
    perc_err(i) = abs((output(i) - output_hat(i)) / output(i));
end
 
% settling time
t_set = -1;
for i = 1: N
    if t_set<0 && perc_err(i)<0.05
        t_set = t_span(i);
    end
    if perc_err(i) >= 0.05
        t_set = -1;
    end
end


%plots

figure(1);
hold on;
plot(t_span, output);
plot(t_span, output_hat);
hold off;
xlabel('time(s)');
title('Real and estimated output');
legend('$output$', '$\hat{output}$','interpreter', 'latex');

figure(2);
plot(t_span, out_dif);
xlabel('time(s)');
title('Difference between real and estimated output');

figure(3);
hold on;
plot(t_span, a_hat);
plot(t_span, b_hat);
hold off;
xlabel('Time(s)');
title('Estimated Parameters');
legend('$\hat{a}$', '$\hat{b}$','interpreter', 'latex');

end