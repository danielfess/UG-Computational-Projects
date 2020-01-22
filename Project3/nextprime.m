function p = nextprime(N)
%NEXTPRIME Takes a number N and gives the next prime
%   NEXTPRIME takes a number N and returns the next prime number
%   strictly greater than N.

if (N < 1)
    %isprime only works for non-negative integers, so we must take
    %this case separately.
    p = 2;
elseif (N >= 4294967291)
    %This is the smallest prime less than 2^32, and isprime doesn't work
    %for N > 2^32, so if N>=4294967291 nextprime encounters an error when
    %it tries to work out isprime(x) for all x > 2^32.
    error('N is too large to compute next prime - N must be less than 4294967291');
else
    N = floor(N)+1;
    %isprime only takes non-negative integer values, so we take the next
    %integer above our input N.
    while (isprime(N)==0)
        N = N+1;
    %We search through the integers using a loop until we find a prime number.
    end
    p = N;
    %The loop ends once we find a value of N such that isprime(N)~=0
    %i.e. N is prime. p, our output, takes this value.
end
end