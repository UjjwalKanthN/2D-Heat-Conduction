function [ out ] = implicit_sor( nx, ny, x, y, dx, dy, T, t, dt, tol, k, k1, k2 )
% Implicit Successive Over-Relaxation Method for Transient State

lambda = 1.09; % Over Relaxation factor
meshgrid(x,y);

T_old = T;
To = T;
nt = t/dt;
sor_iter = 1;

tic
for m = 1:nt
    error = 9e9;
    while (error > tol)
        for i = 2:nx-1
            for j = 2:ny-1
                term1 = T(i-1, j) + T_old(i+1, j);
                term2 = T(i, j-1) + T_old(i, j+1);
                T(i,j) = (1-lambda)*T_old(i,j) + (lambda*((To(i,j) + (k1*term1) + (k2*term2))/(1 + 2*k1 + 2*k2)));
            end
        end
        error = max(max(abs(T_old - T)));
        T_old = T;
        sor_iter = sor_iter + 1;
    end
    To = T;
end
iter_time = toc;

figure(6)
[a, b] = contourf(x, y, T);
colormap(jet)
clabel(a, b);
xlabel('X Length Domain');
ylabel('Y Length Domain');
txt1 = sprintf('Implicit Successive Over-Relaxation Method Iterations = %d', sor_iter);
txt2 = sprintf('Implicit Successive Over-Relaxation Method Simulation Time = %f s', iter_time);
txt3 = sprintf('Final error = %f', error);
colorbar
title({'Transient State';txt1;txt2;txt3});

out = iter_time;

end