function grayscott2(N,str,eu,ev)
%GRAYSCOTT2 Numerically solves the Gray-Scott equations
%   GRAYSCOTT2 takes inputs N and a string, str, and numerically solves the
%   Gray-Scott equations on the square periodic domain [0,1)x[0,1) with a
%   final time of 3000. N determines how many (x,y) points are plotted, and
%   str determines whether spots or stripes conditions are used.

c = .065; %Sets F and c for spots or stripes as specified by str.
if strcmp(str,'spots') == 1
    F = .03;
elseif strcmp(str,'stripes') == 1
    F = .06;
else
    error('str must be "spots" or "stripes"')
end

dx = 1/N;
x1d = (0:dx:1-dx);
y1d = x1d;
[x,y] = meshgrid(x1d,y1d); %Creates grid of x and y.

L = lap1d_matrix(N,dx); %Creates differentiation matrix
I = speye(size(L));
L = kron(I,L) + kron(L,I);

u = min(1, 10*sqrt((x-0.2).^2 + (y-0.2).^2)); %Set initial conditions.
v = max(0, 1 - 10*sqrt((x-0.3).^2 + 2*(y-0.3).^2));
figure(1); clf; pcolor(x,y,u); %Plot initial values of u.
xlabel('x'); ylabel('y'); title('u(x,y,t)')
figure(2); clf; pcolor(x,y,v); %Plot initial values of v.
xlabel('x'); ylabel('y'); title('v(x,y,t)')

tf = 6000;
dt = 0.1;
numsteps = ceil(tf/dt);
dt = tf/numsteps;
u = u(:); %Straighten out u and v.
v = v(:);

for i = 1:numsteps
    dudt = eu*L*u - u.*v.^2 + F*(1-u); %Find du/dt and dv/dt as governed by
    dvdt = ev*L*v + u.*v.^2 - (c+F)*v; %the Gray-Scott equations.
    u = u + dt*dudt; %Iterate u and v using forward euler.
    v = v + dt*dvdt;
    if mod(i,floor(numsteps/10)) == 0 || i == numsteps
        %Plot u and v periodically using pcolor.
        uplot = reshape(u,size(x)); vplot = reshape(v,size(x));
        figure(1); pcolor(x,y,uplot) %Plot u in figure 1.
        xlabel('x'); ylabel('y'); title('u(x,y,t)')
        figure(2); pcolor(x,y,vplot) %Plot v in figure 2.
        xlabel('x'); ylabel('y'); title('v(x,y,t)')
    else
    end
end