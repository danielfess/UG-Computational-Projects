function heat1( N, dt )
%HEAT1 Numerically solves the 1-D heat equation
%   HEAT1 solves the 1-dimensional heat equation with periodic boundary
%   conditions on the x-domain [0,1) with a final time of 0.1, and plots
%   the exact solution too. N determines how many x-points are plotted, and
%   dt determines how often u(x,t) is recalculated.

close all
dx = 1/N; %There are N points in [0,1), so they are 1/N apart.
x = (0:dx:1-dx); %Vector of all the x-points.

L = lap1d_matrix(N,dx); %Produces differentiation matrix.
u = sin(2*pi*x); %Initial condition for u.
uxx = -4*pi^2*u; %Worked out from initial condition for u.

tf = 0.1;
numsteps = ceil(tf/dt); %Uses dt as specified when function is called.
dt = tf/numsteps;
figure(1); plot(x,u,'r.-'); hold on; %Plots intitial condition in red.

for i = 1:numsteps
    u = u + uxx*dt; %Forward euler - u solves the heat eqn, so dudt = uxx.
    uxx = u*L; %Uses L and new values of u to calculate new values of uxx.
    if mod(i,floor(numsteps/6)) == 0 || i == numsteps
        plot(x,u,'k.-');
        axis([0 1 min(-1,min(u)) max(1,max(u))]);
        %Plots u in black at select points in time and when the loop
        %finishes, and sets the axes to always include all plotted points.
    else
    end
end
xlabel('x'); ylabel('u(x,t)');

figure(2); clf; hold on; plot(x,u,'k.-');
syms x; ezplot(exp(-4*pi^2*0.1)*sin(2*pi*x));
%Plots final numerical solution along with exact solution at t = 0.1.
m = exp(-4*pi^2*0.1); %Maximum absolute value of exact solution at t = 0.1.
axis([0 1 min([u,-m]) max([u,m])]);
%Adjusts axes to include all points in both the numerical and exact solutions.
title('Numerical and exact solutions at t = 0.1');
legend('Numerical','Exact'); ylabel('u(x,t)');

end