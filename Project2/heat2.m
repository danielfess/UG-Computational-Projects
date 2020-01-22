close all
N = 50; %N = 50 gives an accurate solution surface.
dx = 1/N;
x1d = (0:dx:1-dx);
y1d = x1d; %x and y take values from 0 to 1-dx that are dx apart.
[x,y] = meshgrid(x1d,y1d);
%Creates a grid of points where each point has a unique representation (x,y).

L = lap1d_matrix(N,dx);
I = speye(size(L));
L = kron(L,I) + kron(I,L);
%Produces differentation matrix that will approximate uxx + uyy.

u = sin(2*pi*x).*cos(4*pi*y); %Initial condition.
dudt = -20*pi^2*u; %Exact initial value of du/dt = uxx + uyy.
dudt = dudt(:); %Straighten out dudt from a matrix to a vector.
figure(1); surf(x,y,u); title('Initial condition') %Plot initial condition.
xlabel('x'); ylabel('y'); zlabel('u(x,y,t)');

u = u(:); %Straighten out u.
tf = 0.1;
dt = 0.25*dx^2;
%In Ex 6 we said dt=<0.5*dx^2, so dt = 0.25*dx^2 ensures this.
numsteps = ceil(tf/dt);

for i = 1:numsteps
    u = u + dt*dudt; %Calculate u at a time dt later using forward euler.
    dudt = L*u; %Approximate uxx + uyy = du/dt.
    %Note u must be straightened out to multiply with L.
    if i == 500 %When t = 0.05 (i.e. i = 500), plot solution.
        uplot = reshape(u,size(x));
        %Reshape u into a matrix since surf doesn't work with vectors. The
        %matrix must be the same size as x (and y) for surf to work, too.
        figure(2); surf(x,y,uplot); title('Solution at t = 0.05')
        xlabel('x'); ylabel('y'); zlabel('u(x,y,t)');
    elseif i == numsteps %Plot final approximate solution.
        uplot = reshape(u,size(x));
        figure(3); surf(x,y,uplot); title('Final solution at t = 0.1')
        xlabel('x'); ylabel('y'); zlabel('u(x,y,t)');
    else
    end
end