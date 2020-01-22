function L = td_list(N)
%TD_LIST
%   TD_LIST takes a natural number between 100 and 999, reverses its
%   digits, finds the differences between these 2 numbers, and adds this
%   number to the list. It repeats this process until a number has been
%   repeated in the list, at which point it outputs the list.

i = 1; L = []; %Initialising variables

if N<100 || N>=1000 || floor(N)~=ceil(N)
    error('N must be a 3 digit natural number')
    %td_list only works for 3 digit numbers, so we introduce an error
    %message for incorrect inputs.
else
    while ismember(N,L)==0
        L(i) = N; %Adds N to the list if it is not already a member.
        c = mod(N,10);
        b = mod(N - c,100)/10;
        a = (N-10*b-c)/100; %Works out the 3 digits of N.
        N = 99*abs(a-c);
        %If N = 100*a+10*b+c is our starting number, then N'=100*c+10*b+a
        %is the flipped version of N, so our new number is abs(N-N') =
        %99*abs(a-c)
        i = i+1;
        %Increment i so the new value of N takes a new position in L and
        %doesn't replace any current members of L.
    end
    %The loop repeats until our new value of N is already in the list, at
    %which point we add this value to the end of our list - we now have the
    %required list so the function is done.
    L(i) = N;
end
end