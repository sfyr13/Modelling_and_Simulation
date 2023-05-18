function error = simulation2(p1, p2)


u1 = @(t)(3*sin(2*t));
u2 = 2;

du1dt = @(t)(6*cos(2*t));
du2dt=0;

tspan = [0:1e-5:3];

N = length(tspan);

y = zeros(N, 2);

for i = 1:N
   h = v(tspan(i));
   y(i, 1) = h(1);
   y(i, 2) = h(2);
end

V_c = y(:, 1);

in_1 = double(u1(tspan))';
in_2 = ones(N, 1);

p = [p1, p2];

zita1 = lsim(tf([-1, 0], [1, p(1) + p(2), p(1) * p(2)]), V_c, tspan');


zita2 = lsim(tf([-1], [1, p(1) + p(2), p(1) * p(2)]), V_c, tspan');

zita3 = lsim(tf([1, 0], [1, p(1) + p(2), p(1) * p(2)]), in_2, tspan');
                   
zita4 = lsim(tf([1], [1, p(1) + p(2), p(1) * p(2)]), in_2, tspan');

zita5 = lsim(  tf([1, 0], [1, p(1) + p(2), p(1) * p(2)]), in_1, tspan');
                    
zita6 = lsim(   tf([1], [1, p(1) + p(2), p(1) * p(2)]), in_1, tspan');

zita = [zita1, zita2, zita3, zita4, zita5, zita6]';

final_val = mse(y, zita, 1) + [p(1) + p(2); p(1) * p(2); 0; 0; 0; 0];

RC_inv = final_val(1)
LC_inv = final_val(2)


[t_f, V_c_f] = ode45(@(t_f, V_c_f) odefcn2(t_f, V_c_f, RC_inv, LC_inv), tspan, [0, 0]);

sum = 0;

for t = 1: N
    sum = sum + abs((V_c(t) - V_c_f(t, 1)));
end
e = sum / N;


figure(3);
plot(tspan, V_c);
xlabel('Time(s)')
ylabel('System Response');


end