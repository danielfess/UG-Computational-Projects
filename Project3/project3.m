%% Project 3 Number Theory


%% Question 1 - Primes

%In this question we investigate the properties of primes and in particular
%of consecutive primes.

%% Exercise 1

%In this exercise I have made a function which takes an input N and returns
%the next prime strictly greater than it.

%See nextprime.m below for code and comments:

type nextprime.m

%Some examples of the code working:
p = nextprime(18)
p = nextprime(23)
p = nextprime(2343)


%% Exercise 2

%This exercise asks us to find the first 15 primes n1, such that if n2 is
%the next prime, then n2-n1>=40.

n1 = 2; %We start searching for values of n1 at the smallest prime - 2.
L = zeros(1,15); %We preallocate L as a 1x15 matrix to improve efficiency.
i = 1; %i counts the number of primes we have found satisfying n2-n1>=40.
while i <= 15
    n2 = nextprime(n1);
    if (n2 - n1) >= 40
        L(i) = n1;
        %When n2-n1>=40, we add n1 to our list L in the i-th place.
        i = i+1;
        %We increment i since we have found a prime satisfying the given condition.
    else %We do nothing if n1 doesn't satisfy n2-n1>=40; we don't add it to the list L.
    end
    n1 = n2;
    %n1 takes the value of nextprime(n1) = n2, and then the loop repeats
    %until we have our 15 primes - once we have our 15 primes, i = 16, so
    %we only need the loop to run for i<=15.
end
L %We output our list of the first 15 primes n1 satisfying n2-n1>=40.


%% Exercise 3

%This exercise asks us to find all primes n1<=1000 such that, if n2 and n3
%are the next 2 primes, n1+n2+n3 is divisible by 19.

n1 = 2; n2 = 3; %We initialise our variables by picking the first 2 primes.
i = 1; L = [];
%i counts the number of primes satisfying the condition, and L contains all such
%primes - it starts as an empty list as we haven't yet found any such primes.
while n1 <= 1000
    n3 = nextprime(n2);
    if mod(n1+n2+n3,19) == 0 %If n1+n2+n3 is divisible by 19 then this is 0.
        L(i) = n1; %Add n1 to the list L in the i-th place.
        i = i+1; %Increment i since we have found a prime satisfying the condition.
    else %Do nothing since n1 doesn't satisfy the condition.
    end
    n1 = n2;
    n2 = n3; %n1 and n2 take the values of the next primes.
end
L
%We output our list L once the loop finishes and we have searched through
%all the primes less than 1000.



%% Question 2 - Twin Primes

%This question is about twin primes, which are primes p such that (p-2) or
%(p+2) is prime as well.

%% Exercise 4

%For this exercise I have written a function twin which takes two input
%values N1 and N2 and produces a matrix L of all pairs of twin primes (n,n+2)
%such that N1<=n<=N2. It also counts how many twin primes there are
%satisfying this condition - p gives this value.

%See twin.m below for code and comments:

type twin.m

%Some examples of twin working:

[L,p] = twin(2,46)
[L,p] = twin(567,785)


%% Exercise 5

%This exercise simply asks us to put our twin function to use.

[L1,p1] = twin(5,100)
[L2,p2] = twin(5,500)
%So there are 46 twin primes where 5<=n<=500, since p2 = 46.


%% Exercise 6

%In this exercise we estimate Brun's constant using the first 10000 twin
%prime pairs.

n1 = 2; i = 1; s = 0;
%Initialising variables - n1 takes the value of the first prime, 2; i
%counts through how many twin primes we have found; and s sums the
%reciprocals of the twin primes, which starts at 0 as we have yet to find
%any twin primes.
while i<=10000
    %The loop runs until we have found the 10000th twin prime pair, at
    %which point i becomes 10001, so the loop only needs to run for i<=10000.
    n2 = nextprime(n1);
    if (n2-n1)==2 %Test to see if (n1,n2) is a twin prime pair.
        s = s + 1/n1 + 1/n2; %Add the reciprocals of the twin prime pair to s.
        i = i + 1; %Increment i as we have found a twin prime pair.
    else %Do nothing if (n1,n2) is not a twin prime pair.
    end
    n1 = n2;
    %n1 takes the value of the next prime, n2, and the loop repeats and
    %scans through all the primes until we find the 10000th twin prime pair.
end
s %Output s - this is our estimate of Brun's constant.


%As we have summed the reciprocals of the twin primes over the first 10000
%pairs of twin primes, the estimate should be fairly accurate. However,
%Brun's constant converges VERY slowly, and it turns out that our estimate
%is actually not very close to the tightest bounds on Brun's constant -
%calculations have shown it to be around 1.9, which is quite different from
%our estimate of 1.7140 despite using the first 10000 pairs of twin primes!
%Having doing some research on Brun's constant, I am not very confident in
%my estimate, and am only confident in the first digit.



%% Question 3 - Triple Digits

%In this question we look at 3 digit numbers and at properties of their
%period.

%% Exercise 7

%I have made a function td_list which creates a list of numbers specific to
%each 3 digit number as described in the project manual.

%See td_list.m below for code and comments:

type td_list.m

%Some examples of td_list working:

L = td_list(789)
L = td_list(453)
L = td_list(101)

%% Exercise 8

%For this exercise I have written a function td_period which works out the
%period of a 3 digit number.

%See td_period.m below for code and comments:

type td_period.m

%Some examples of td_period working:

p = td_period(789)
p = td_period(453)
p = td_period(101)

%% Exercise 9

%We now prove that every 3 digit number has either period 1 or period 5,
%using our functions td_period and td_list.

L = []; k = 1; %Initialising variables.
%L will contain any numbers which don't have period 1 or 5.
for i = 100:999 %Loop runs through all 3 digit numbers.
    if td_period(i)==1 || td_period(i)==5 %Do nothing if i has period 1 or 5.
    else
        L(k) = i;
        k = k+1;
        %If a number does not have period 1 or 5 we add it to our list L,
        %and we increment k so that the next number without period 1 or 5
        %is placed in L in a new postion, and doesn't replace any current
        %members of L.
    end
end
L
%Once the loop ends we output L, which is our list of all 3 digit numbers
%which don't have period 1 or 5.


%Note that L remains empty, so we have shown that all 3 digit numbers have
%either period 1 or 5. This is a proof, as we have checked the period of
%every single 3 digit number. I would not call it an elegant proof, as
%although a computer is very quick at checking all 3 digit numbers for
%their period, the proof works by brute force and does not involve any
%clever leaps in logic like a written proof might.