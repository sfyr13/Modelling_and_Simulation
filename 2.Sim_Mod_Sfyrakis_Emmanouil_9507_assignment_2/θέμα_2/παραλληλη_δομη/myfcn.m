function dx = myfcn(t, x, u, g1, g2, n, a, b)

%x = [output, theta1_hat, theta2_hat, output_hat]

dx(1) = -a*x(1)+b*u(t);
dx(2) = -g1*(x(1)+n(t)-x(4))*x(4);
dx(3) = g2*(x(1)+n(t)-x(4))*u(t);
dx(4) = -x(2)*x(4)+x(3)*u(t);

dx=dx';
end