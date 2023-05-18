function dxdt = odefcn(t, x, m, b, k, u)

    dxdt(1)=x(2);
    dxdt(2)=(1/m) * (-k * x(1) -b * x(2) + u(t));
    dxdt=dxdt';


end