% Script simulateLottery.m
% Simulate the results of a large number (e.g. 100000) of lottery tickets.
%
% Record of revisions:
%     Date        Programmer      Description of change
%     ====        ==========      =====================
%   06/10/16      Alice Chen          Original code

% Set the number of simulations.
n = 100000;

% Generate a random jackpot number array.
j = randTicketNumbers();

% count records the number of times each prize occurs.
% count(5) for grand prize, count(4) for first prize, count(3) for second
% prize, count(2) for third prize, and count(1) for no prize.
count = zeros(1, 5);
for k = 1:n
    % Generate a random ticket number array.
    t = randTicketNumbers();
    % Determine what prize is won.
    [p, a] = checkPrize(t, j);
    % Increment the corresponding count.
    count(5-p) = count(5-p) + 1;
end

% Draw a histogram showing the number of occurrence of each prize.
bar(count)
title(['Number of occurrence of each prize in ' num2str(n) ' simulations'])
ylabel('Number of occurrence')
labels = {'No Prize', 'Third Prize', 'Second Prize', 'First Prize', ...
    'Grand Prize'};
set(gca, 'XTick', 1:5, 'XTickLabel', labels);

% freq records the frequency of winning each prize with the same indexing
% as count, except that frequency of winning no prize is not needed.
freq = zeros(2, 5);
for k = 2:5
    freq(k) = count(k)/n;
end

% Compute the average amount of money won by each ticket.
mavg = 0;
aarray = [0 2 10 100 5000]; % corresponding amount won
for k = 2:5
    mavg = mavg + freq(k) * aarray(k);
end

% Print the statistics of frequencies and average amount on the screen.
fprintf('The average amount of money won by each ticket is $%1.4f.\n', ...
    mavg) % Calculated: $1.9292
fprintf('Grand prize occurred %d times in %d trials. Frequency: %1.4f.\n', ...
    count(5), n, freq(5)) % Calculated: 1/10^4 = 0.0001
fprintf('First prize occurred %d times in %d trials. Frequency: %1.4f.\n', ...
    count(4), n, freq(4)) % Calculated: 36/10^4 = 0.0036
fprintf('Second prize occurred %d times in %d trials. Frequency: %1.4f.\n', ...
    count(3), n, freq(3)) % Calculated: 486/10^4 = 0.0486
fprintf('Third prize occurred %d times in %d trials. Frequency: %1.4f.\n', ...
    count(2), n, freq(2)) % Calculated: 2916/10^4 = 0.2916
