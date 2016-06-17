% Script get20new.m
% What is the most likely number of times that one has to roll a die 
% to get at least 20 points?
%
% Record of revisions:
%     Date        Programmer      Description of change
%     ====        ==========      =====================
%   06/09/16      Alice Chen          Original code

% counts(n) is the number of times n rolls are needed to get 20 points.
% The number of rolls is at most 20 (worst case: each roll yields 1).
counts = zeros(1,20);
% We do 10000 simulations to ensure accuracy.

for k = 1:10000
    n = rollsUntil(20);
    counts(n) = counts(n) + 1;
end

[maxcount, maxn] = max(counts);

% Answer to the question. Result is 6 (in all cases I tried).
disp(['Most frequent: ' num2str(maxn)])