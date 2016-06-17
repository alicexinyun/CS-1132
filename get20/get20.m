% Script get20.m
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
% narray(k) is the number of rolls needed for the kth simulation.
% We do 10000 simulations to ensure accuracy.
narray = zeros(1,10000);
parray = zeros(1,10000);

for k = 1:10000
    points = 0; n = 0;
    while points < 20
        point = randi([1 6]); % result of one roll
        points = points + point; % cumulative result of all previous rolls
        n = n + 1;
    end
    counts(n) = counts(n) + 1;
    narray(k) = n;
    parray(k) = points;
end

[maxcount, maxn] = max(counts);

% Answer to the question. Result is 6 (in all cases I tried).
disp(['Most frequent: ' num2str(maxn)])

% According to probability theories. Value is 5.7-ish.
disp(['Calculated: ' num2str(20/3.5)])
% According to simulation results. Value is 6.2-ish.
disp(['Simulated avg: ' num2str(mean(narray))])

% Q: Why is the simulated avg inconsistent with the calculated expectation?
% A: The calculated expectation is for points = 20,
%    but the simulated avg is for points >= 20,
%    and thus the simulated avg is greater than the calculated expectation.
error = (mean(parray)/mean(narray) - 3.5)/3.5;
disp(error) % should be small