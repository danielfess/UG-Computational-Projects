function [L,p] = twin(N1,N2)
%TWIN Outputs pairs of twin primes (n,n+2) where N1<=n<=N2 and counts
%the number of such twin primes.
%   For every pair of twin primes (n,n+2) such that N1<=n<=N2, TWIN returns
%   each pair in L and counts the number p of twin primes satisfying
%   N1<=n<=N2.

if N2 >= 4294967291
    error('N2 is too large to compute all twin primes up to N2 - N2 must be less than 4294967291')
    %nextprime, and hence twin, don't work if N is greater than or equal
    %to this value (see nextprime.m for more detailed comment on this).
else    
    L = []; i = 1;
    %L will contain all the twin prime pairs, and i counts the number of
    %pairs found.
    n = nextprime(ceil(N1)-1);
    %n is the smallest prime greater than or equal to N1.
    while n <=N2
        m = nextprime(n);
        if (m-n) == 2 %Tests whether (n,m) is a twin prime pair.
            L(i,1) = n; %If (n,m) is a twin prime pair, we add them to L.
            L(i,2) = m;
            i = i+1; %Increments i as we have found a twin prime pair.
        else %Do nothing since if (m-n)~=2, (m,n) is not a twin prime pair
             %so we don't add it to L.
        end
        n = m;
        %n takes on the value of the next prime number, m, and the loop repeats.
    end
end
%Once n > N2 we will have found all the twin prime pairs (n,n+2) satisfying
%N1<=n<=N2 so the function outputs the matrix L containing all such pairs.


if N1<=3 && N2>=5
    p = length(L)*2 - 1;
    %L has 2 columns, so the number of twin primes in L is length(L)*2.
    %However, in this case 5 appears twice in L so we make p=length(L)*2-1.
elseif N1<=3 && N2<5
    p = 2;
    %(3,5) is the only twin prime pair in L in this case, so p = 2.
else
    p = length(L)*2;
    %In all other cases, no primes appear more than once in L, so the
    %number of twin primes, p, is simply length(L)*2.
end
end