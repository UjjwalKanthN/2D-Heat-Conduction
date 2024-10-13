% Solving Steady and Unsteady states for 2-D conduction equation using
% iterative methods

clear all
close all
clc

% Initial Conditions
L = 1; % Unit square length domain
nx = 10; % grid points along X axis
ny = nx; % grid points along Y axis

% Grid spacing

x = linspace(0, L, nx);
dx = L/(nx-1);
y = linspace(0, L, ny);
dy = L/(ny-1);

error = 9e9;
tol = 1e-5;
t = 5;
dt = 1e-2;
alpha = 0.3;

k = 2*(1/(dx^2)+1/(dy^2)); % Assumption for Steady state constants
% Assumption for Unsteady state constants
k1 = alpha*(dt/dx^2);
k2 = alpha*(dt/dy^2);

% Boundary Conditions
T = ones(nx, ny);
T(:, 1) = 400; % Left
T(:, end) = 800; % Right
T(1, :) = 600; % Top
T(end, :) = 900; % Bottom

% Edge Refining
T(1,1) = (600 + 400)/2;
T(1, end) = (600 + 800)/2;
T(end, 1) = (900 + 400)/2;
T(end, end) = (900 + 800)/2;

% Steady State Analysis
for iter_method = [1 2 3]
    if iter_method == 1
       time = jacobi( nx, ny, x, y, dx, dy, T, tol, k );
    else if iter_method == 2
            time = gauss_seidel( nx, ny, x, y, dx, dy, T, tol, k );
        else if iter_method == 3
                time = sor( nx, ny, x, y, dx, dy, T, tol, k );
            end
        end
    end
end

%Unsteady or Transient State Analysis
%Implicit Approach
for iter_method = [1 2 3]
    if iter_method == 1
       time = implicit_jacobi( nx, ny, x, y, dx, dy, T, t, dt, tol, k, k1, k2 );
    else if iter_method == 2
            time = implicit_gauss_seidel( nx, ny, x, y, dx, dy, T, t, dt, tol, k, k1, k2 );
        else if iter_method == 3
                time = implicit_sor( nx, ny, x, y, dx, dy, T, t, dt, tol, k, k1, k2 );
            end
        end
    end
end

%Explicit Approach
for iter_method = [1 2 3]
    if iter_method == 1
        time = explicit_jacobi( nx, ny, x, y, dx, dy, T, t, dt, tol, k, k1, k2 );
    else if iter_method == 2
            time = explicit_gauss_seidel( nx, ny, x, y, dx, dy, T, t, dt, tol, k, k1, k2 );
        else if iter_method == 3
                time = explicit_sor( nx, ny, x, y, dx, dy, T, t, dt, tol, k, k1, k2 );
            end
        end
    end
end