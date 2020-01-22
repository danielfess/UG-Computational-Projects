function p = td_period(N)
%TD_PERIOD Computes the period of a 3 digit natural number
%   TD_PERIOD takes a natural number N between 100 and 999 and finds its
%   period.

if N<100 || N>=1000 || floor(N)~=ceil(N)
    error('N must be a 3 digit natural number')
    %td_list only works for 3 digit numbers, so we introduce an error
    %message for incorrect inputs.
else
    L = td_list(N); %Use td_list to create the corresponding list for N.
    L = fliplr(L); %Flip the list so the last element of L, the repeated
                   %element, is now the first.
    x = L(1); %Denote the repeated element by x.
    p = 2;
    while L(p)~=x
        p = p+1;
    %Loop searches through the elements of the list until it finds the
    %repeated element again.
    end
    %When the loop finishes, it gives p as the position of the repeated
    %element in the list; the period is the number of elements in our
    %flipped list before we reach the repeated element again, so we
    %subtract 1 from p to count the elements before the repeated element,
    %which is the period.
    p = p-1;
end
end