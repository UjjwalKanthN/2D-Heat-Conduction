function [ out ] = sor( nx, ny, x, y, dx, dy, T, tol, k )
% Steady state Successive Over-Relaxation Method

lambda = 1.5; % Over Relaxation factor
meshgrid(x,y);

T_old = T;
sor_iter = 1;
error = 9e9;

tic
while (error > tol)
    for i = 2:nx-1
        for j = 2:ny-1
            term1 = (T(i-1, j) + T_old(i+1, j))/(k*(dx^2));
            term2 = (T(i, j-1) + T_old(i, j+1))/(k*(dy^2));
            T(i,j) = (1-lambda)*T_old(i,j) + (term1 + term2)*lambda;
        end
    end
    error = max(max(abs(T_old - T)));
    T_old = T;
    sor_iter = sor_iter + 1;
end
iter_time = toc;

figure(3)
[a, b] = contourf(x, y, T);
colormap(jet)
clabel(a, b);
xlabel('X Length Domain');
ylabel('Y Length Domain');
txt1 = sprintf('Successive Over-Relaxation Method Iterations = %d', sor_iter);
txt2 = sprintf('Successive Over-Relaxation Method Simulation Time = %f s', iter_time);
txt3 = sprintf('Final error = %f', error);
colorbar
title({'Steady State';txt1;txt2;txt3});

out = iter_time;
end