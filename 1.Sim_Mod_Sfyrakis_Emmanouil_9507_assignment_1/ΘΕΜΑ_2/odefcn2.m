function dxdt = odefcn2(t, x, RC_inv, LC_inv)

u1 = @(t)(3*sin(2*t));
u2 = 2;
du2dt=0;


dxdt(1) = x(2);
dxdt(2) = -RC_inv * x(2) - LC_inv * x(1) + RC_inv * du2dt + LC_inv * u2 + RC_inv * u1(t);
dxdt=dxdt';


end


