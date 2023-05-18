function error = simulation1(p1, p2)

close;

%parameters
m = 10;
b = 0.3;
k = 1.5;
u = @(t) (10*sin(3*t)+5);

%initial conditions
x0(1) = 0;
x0(2) = 0;

tspan = [0:0.1:10];

%computation of outputs and inputs

[t, y] = ode45(@(t, y) odefcn(t, y, m, b, k, u), tspan, x0);

in_vec = u(t(:));

 
p = [p1, p2];

   
syms b_est;
syms m_est;
syms k_est;

%θ_λ and ζ
theta_lambda = [  b_est / m_est - (p(1) + p(2)); k_est / m_est - (p(1) * p(2)); 1 / m_est  ];

zita1 = lsim(   tf([-1, 0], [1, p(1) + p(2), p(1) * p(2)]), y(:, 1), t);

zita2 = lsim(   tf([-1], [1, p(1) + p(2), p(1) * p(2)]), y(:, 1), t);

zita3 = lsim(   tf([1], [1, p(1) + p(2), p(1) * p(2)]), in_vec, t);

zita = [zita1, zita2, zita3]';

%estimated parameters
eq = theta_lambda == mse(y, zita, 1);
sol = solve(eq, [m_est, b_est, k_est]);
m_f = double(sol.m_est)
b_f = double(sol.b_est)
k_f = double(sol.k_est)

final_val = [m_f, b_f, k_f];
    
error = abs((m - m_f) / m) + abs((b - b_f) / b) + abs((k - k_f) / k);

 % error computation between the real system and the model
[t_f, y_f] = ode45(@(t_f, y_f) odefcn(t_f, y_f, m_f, b_f, k_f, u), tspan, x0);
err = zeros(length(y), 1);    
 for i = 1:length(y)
   err(i) = abs((y(i, 1) - y_f(i, 1)) / y(i, 1));
 end

%plots

figure(1);
plot(t,y(:,1))
ylabel('system 1 response');
xlabel('time(s)');

end