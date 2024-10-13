function [ out ] = jacobi( nx, ny, x, y, dx, dy, T, tol, k )
% Steady state Jacobi method

meshgrid(x,y);

T_old = T;
jac_iter = 1;
error = 9e9;

tic
while (error > tol)
    for i = 2:nx-1
        for j = 2:ny-1
            term1 = (T_old(i-1, j) + T_old(i+1, j))/(k*(dx^2));
            term2 = (T_old(i, j-1) + T_old(i, j+1))/(k*(dy^2));
            T(i,j) = term1 + term2;
        end
    end
    error = max(max(abs(T_old - T)));
    T_old = T;
    jac_iter = jac_iter + 1;
end
iter_time = toc;

figure(1)
[a, b] = contourf(x, y, T);
colormap(jet)
clabel(a, b);
xlabel('X Length Domain');
ylabel('Y Length Domain');
txt1 = sprintf('Jacobi Method Iterations = %d', jac_iter);
txt2 = sprintf('Jacobi Method Simulation Time = %f s', iter_time);
txt3 = sprintf('Final error = %f', error);
colorbar
title({'Steady State';txt1;txt2;txt3});

out = iter_time;
end