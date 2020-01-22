function fe(u0,v0,str,dt)
%FE Solves the ODE form of the gray-scott equations numerically
%   fe takes initial conditions for u and v, sets F and c for either spots
%   or stripes patterns, and numerically solves the ODE form of the
%   Gray-Scott equations (i.e. ignoring all partial derivative terms). dt
%   represents the time-step between iterations of u and v.

tf = 100; %Final time is 100.
numsteps = ceil(tf/dt); %Works out how many times loop below needs to run.
dt = tf/numsteps; %Re-adjusts dt so numsteps*dt = tf.

clf; hold on
c = .065;
if strcmp(str,'spots') == 1
    F = .03;
elseif strcmp(str,'stripes') == 1
    F = .06;
else
    error('str must be "spots" or "stripes"')
end
%The above conditional sets c and F depending on whether stripes or spots
%initial conditions are wanted.

u = u0; v = v0; %Sets variables u and v to their initial values.
plot(0,u0,'r.'); plot(0,v0,'k.') %Plots initial values of u and v.
for n = 1:numsteps
    dudt = -u*v^2 + F*(1-u); %Works out du/dt and dv/dt for u,v at a
    dvdt = u*v^2 - (c+F)*v;  %specific time n*dt.
    u = u + dt*dudt; %Use forward euler method to approximate u at a time
    v = v + dt*dvdt; %dt ahead.
    plot(n*dt, u, 'r.');
    plot(n*dt, v, 'k.'); %Plot u and v for each value of time.
end
legend('u','v')
end