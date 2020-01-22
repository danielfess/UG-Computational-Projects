function L = lap1d_matrix( N , dx )
%LAP1D_MATRIX Produces an N x N second order differentiation matrix
%   LAP1D_MATRIX produces an N x N matrix which approximates the second
%   partial derivative with respect to x of a periodic function u(x,t) at
%   points which are dx apart.

e = ones(N,1); %Creates an Nx1 column vector of 1s
L = spdiags([e -2*e e], [-1 0 1], N, N);
%Creates a sparse matrix with -2's along the leading diagonal and -1's
%along the diagonals 1 above and 1 below the leading diagonal
L(1,N) = 1; %This mean the second derivatives at x=0 and x=1-dx rely on
L(N,1) = 1; %u(x,t) at the other point, giving periodic boundary conditions.
L = L/dx^2;
%Scales the entries of L so it approximates the second partial derivative
%of u with respect to x.

end