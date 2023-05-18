function dx = myfcn(  t, x, u, am, g, a, b )

% x = [x, theta1_hat, theta2_hat, phi1, phi2, x_hat]

dx(1) = -a*x(1) + b*u;
dx(2) = g * (x(1) - x(6)) * x(4);
dx(3) = g * (x(1) - x(6)) * x(5);
dx(4) = -am * x(4) + x(1);
dx(5) = -am * x(5) + u;
dx(6) = (x(2) - am) * x(6) + x(3) * u;

dx=dx';

end