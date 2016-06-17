function result = myRandInt(startInt, endInt)
% Returns an integer from startInt to endInt, inclusive, with equal 
% probability. 
% If startInt > endInt, use startInt as the upper bound and endInt as the 
% lower bound.
%
% Record of revisions:
%     Date        Programmer      Description of change
%     ====        ==========      =====================
%   06/10/16      Alice Chen          Original code

% Swap startInt and endInt if the former is greater than the latter.
if startInt > endInt
    m = startInt;
    startInt = endInt;
    endInt = m;
end

% n is the number of integers from startInt to endInt, inclusive.
n = endInt - startInt + 1;

x = rand(1);
for k = 1:n
    if ((k-1)/n < x) && (x < k/n) % to ensure each has a probability of 1/n
        result = startInt + k - 1;
    end
end

    