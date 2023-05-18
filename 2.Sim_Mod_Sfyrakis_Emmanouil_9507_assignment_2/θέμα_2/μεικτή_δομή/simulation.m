function[t_set] = simulation(theta_m, g1, g2)

a = 1.5;
b = 2;
u = @(t)3*cos(2*t);
n = @(t)0.25*sin(2*pi*30*t);

x0(1:4) = 0;
t_span = 0:0.01:20;

N = length(t_span);

[~, x] = ode45(@(t, x) myfcn(t, x, u, theta_m, g1, g2, n, a, b), t_span, x0);

output = x(:, 1);
theta1_hat = x(:, 2);
theta2_hat = x(:, 3);
output_hat = x(:, 4);
a_hat = theta1_hat;
b_hat = theta2_hat;

%output with noise
out_n = zeros(N, 1);
for i = 1:N
    out_n(i) = output(i)+n(t_span(i));
end

for i = 1:N
    out_dif(i) = out_n(i)-output_hat(i)
end

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


%Lyapunov function
V = zeros(N, 1);
for i = 1:N
    V(i) = ((output(i)-output_hat(i))^2)/2 + (1/(2*g1))*(theta1_hat(i)-a)^2+(1/(2*g2))*(theta2_hat(i)-b)^2;
end

%plots
figure(1);
hold on;
plot(t_span, output);
plot(t_span, output_hat);
plot(t_span, out_n);
hold off;
xlabel('time(s)');
title('Real, estimated and noisy output');
legend('$output$', '$\hat{output}$','$out_n$' ,'interpreter', 'latex');

figure(2);
plot(t_span, out_dif);
xlabel('time(s)');
title('Difference between noisy and estimated output');

figure(3);
hold on;
plot(t_span, a_hat);
plot(t_span, b_hat);
hold off;
xlabel('Time(s)');
title('Estimated Parameters');
legend('$\hat{a}$', '$\hat{b}$','interpreter', 'latex');