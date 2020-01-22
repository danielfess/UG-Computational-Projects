%% Project 2 Pattern Formation


%%
%This project asks us to investigate the Gray-Scott equations, which model
%pattern formation in a reaction-diffusion system, and also numerical
%methods for solving ODEs and PDEs.


%% Exercise 1

%We are looking for a steady state solution to the equations:

%du/dt = -uv^2 + F(1-u)
%dv/dt = uv^2 - (c+F)v

%A steady-state solution u = 1, v = 0 is easily found by inspection,
%where du/dt and dv/dt both equal 0. This is known as the zero-diffusion
%steady state.


%% Exercise 2

%I have created a function fe which, given dt along with initial conditions
%for u and v, and using values of F and c corresponding to spots or
%stripes, solves the ODE form of the Gray-Scott equations with a final time
%of 100. This makes it easier to compare solutions with different initial
%conditions, rather than writing a single script.

type fe.m

%%
%Here are some examples of the code working and producing graphs showing
%the evolution of u and v, with different initial conditions in each case.

%Stripes:
figure(1)
fe(0.5,0.5,'stripes',0.1)
figure(2)
fe(0,1,'stripes',0.1)

%%
%These solution curves all tend to the zero diffusion steady state where
%u = 1 and v = 0.

%%
%Spots:
figure(3)
fe(0.2,0.7,'spots',0.1)
figure(4)
fe(0.4,0.2,'spots',0.1)

%%
%The solution curves for spots have mostly the same behaviour - i.e. they
%tend to the zero diffusion steady state. If our final time were larger
%this would be easier to see.

%%
%The ODE system is very stable since all initial conditions of u and v
%between 0 and 1 tend to the zero diffusion steady state, so small changes
%in the initial conditions produce only small, if any, changes in the
%output.


%% Exercise 3

%In this exercise we investigate the effect of changing dt on the numerical
%solution of our ODEs, and look at the numerical stability of our code.

%Small changes in dt generally don't change the solution noticeably, but if
%dt is close to its critical value, above which the code produces divergent
%solutions, then small changes in dt can turn an accurate solution into a
%divergent one.

%The critical value of dt depends on our intital conditions u0 and v0.
%For instance, u0 = 0.5, v0 = 0.8 with stripes inital conditions has
%critical value dt = 2.777, but for u0 = 0.3, v0 = 0.3 and spots intial
%conditions, the code still provides a bounded solution when dt = 10.

%For the code to be numerically stable, dt must be small enough that no
%matter the initial conditions, the solution always remains bounded. Note
%that du/dt and dv/dt are greatest in modulus when u = v = 1, and that the
%solution is most likely to diverge when these are large in modulus - when
%u0 = v0 = 1, we find the critical time for spots and stripes is 1.4084. So
%the code is numerically stable, for all initial conditions, below dt =
%1.084.

%% Exercise 4

%This exercise asks us to write a function, lap1d_matrix, which creates a
%matrix that approximates the second derivative of a function.

%An example of lap1d_matrix working:

lap1d_matrix(4,0.2)

%%
%Here is the code for lap1d_matrix with comments:

type lap1d_matrix.m


%% Exercise 5

%Instead of writing a script, I have written a function heat1.m which takes
%inputs N and dt, and then numerically solves the 1-D heat equation. The
%final time, tf, and the initial condition for u are fixed. The function
%makes it easier to compare the effect of different values of N and dt on
%the accuracy of the solution, and in particular makes it easier to find
%the critical time associated with each N as we will see in Exercise 6.

type heat1.m


%%
%Now we use our function to numerically solve the heat equation with
%initial conditions of u(0,x) = sin(2*pi*x), N = 16, dt = 0.0005 and
%tf = 0.1.

heat1(16,0.0005)


%% Exercise 6

%We now have to find a relationship between dx and the critical time, dt,
%above which the code is not numerically stable.

%For this I used my function heat1 to find the critical times associated
%with various values of N. I changed the final time to 0.3 in heat1, as
%divergent solutions may only take large values at later times.

%Here are some values I calculated:

%N = 20     dx = 0.05      dt = 0.001315789
%N = 40     dx = 0.025     dt = 0.000316122
%N = 60     dx = 0.0166..  dt = 0.000139534
%N = 80     dx = 0.0125    dt = 0.000078328
%N = 100    dx = 0.01      dt = 0.000050091

%Looking at the data it seems that dt = k*dx^2, where k is a constant.
%Working out k from each pair of values we see k is approximately 0.5, with
%k seeming to tend to 0.5 as dx gets smaller. Certainly 0.5*dx^2 is less
%than dt for the above data, so taking dt =< 0.5*dx^2 should give numerical
%stability for all choices of dx.


%% Exercise 7

%This exercise asks us to solve the 2-D heat equation with periodic
%boundary conditions on the domain [0,1)x[0,1). The initial condition is
%u = sin(2*pi*x)*cos(4*pi*y), and the final time is 0.1. I chose N = 50 as
%this gives a lot of points to plot so the solution surface seems smooth,
%as the exact solution would.

heat2

%%
%Here is the code for heat2.m with comments:

type heat2.m

%% Exercise 8

%Now we are finally ready to compute numerical solutions to the Gray-Scott
%equations, using what we have learnt so far about numerically solving
%ODEs and PDEs.

%I have written a function grayscott2.m instead of a script, as this allows
%us to easily change N, the diffusion constants eu and ev, and F and c via
%switching between spots and stripes conditions.

type grayscott2.m

%%

%We will take eu = 5*10^-5, ev = 2*10^-5 and N = 100.

%Stripes:

eu1 = 5*10^-5; ev1 = 2*10^-5;
grayscott2(100,'stripes',eu1,ev1)

%%
%Spots:

grayscott2(100,'spots',eu1,ev1)

%% Exercise 9

%Setting the diffusion constants to 0 and taking N = 100:
%(The below plot is the same for stripes and spots.)

grayscott2(100,'spots',0,0)

%%
%The solution to this problem is that u = 1 for most of the (x,y) in
%[0,1)x[0,1), as shown by the plot. However, there is an odd region around
%(0.2,0.2), where u0 is not 1 or v0 is not 0, where u = 0. v is 0
%everywhere except the points (x,y) on the ellipse (x-.3)^2+2*(y-.3)^2 =
%0.01, where v takes various values. We would expect v = 0 and u = 1
%everywhere, since in Exercise 2 we showed that when we ignore the
%diffusion terms, regardless of the initial values of u or v at a point, u
%and v tend to 1 and 0 respectively - the zero difusion steady state.

%%
grayscott2(70,'spots',5*10^-6,5*10^-6)

%Here v tends to a steady state with a maximum value of 1 around (0.3,0.3)
%(the red part of the plot) and decreases uniformly all around this point
%to a minimum at (0.9,0.85). u tends to a steady state too, but its
%behaviour is strange in that most points are 0 or 1 and there are very few
%points with u in (0,1).

%%
grayscott2(70,'spots',10^-5,10^-5)

%In this case u and v also both reach a steady state. Like in the previous
%example, v reaches a maximum of 1 at around (0.3,0.3) and decreases
%uniformly around that point. However, we see u has different behaviour
%here - it is 0 everywhere except a small section around (0.8,0.8).

%%
%It seems that in general, when the diffusion constants are non-zero and
%equal, u and v reach steady states, where v varies from 0 to 1 across
%[0,1)x[0,1), with a maximum of 1 around (0.3,0.3) and a minimum of 0
%around (0.9,0.85), and where u's behaviour is unpredictable.