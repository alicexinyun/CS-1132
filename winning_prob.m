% Script file: winning_prob.m
%
% Purpose:
%     To estimate Ann and Bob's winning probabilities in a coin-flipping
%     game in which Ann and Bob each flips a coin twice in a game. 
%     Ann wins if she gets two tails; 
%     Bob wins if his two flips are different. 
%     If there is a tie, then neither player wins the game.
%
% Record of revisions:
%     Date        Programmer      Description of change
%     ====        ==========      =====================
%   06/09/16      Alice Chen          Original code
%
% Define variables:
%     ptail - Probability of tails (e.g. 1/2 for a fair coin)
%     n     - Number of simulated games
%     i     - The ith game simulated
%     m     - Random number in (0, 1)
%     ann1  - Ann's first flip result
%     ann2  - Ann's second flip result
%     bob1  - Bob's first flip result
%     bob2  - Bob's second flip result
%     awin  - Number of wins Ann has got so far
%     bwin  - Number of wins Bob has got so far
%     aprob - Ann's winning probability [percent]
%     bprob - Bob's winning probability [percent]
%     acalp - Ann's calculated winning probability [percent]
%     bcalp - Bob's calculated winning probability [percent]

ptail = input('Enter the probability of tails (a number in [0, 1]): ');

for n = [100 1000 10000]
    awin = 0;
    bwin = 0;
    for i = 1:n
        % Determine the results of the flips.
        m = rand(1);
        if m <= ptail
            ann1 = 'tail';
        else
            ann1 = 'head';
        end
        m = rand(1);
        if m <= ptail
            ann2 = 'tail';
        else
            ann2 = 'head';
        end
        m = rand(1);
        if m <= ptail
            bob1 = 'tail';
        else
            bob1 = 'head';
        end
        m = rand(1);
        if m <= ptail
            bob2 = 'tail';
        else
            bob2 = 'head';
        end
        % Determine the winner of the game.
        if strcmp(ann1, 'tail') && strcmp(ann2, 'tail') && ...
                strcmp(bob1, bob2)
            awin = awin + 1;
        end
        if (strcmp(bob1, bob2) == 0) && ...
                (strcmp(ann1, 'head') || strcmp(ann2, 'head'))
            bwin = bwin + 1;
        end
    end
    aprob = awin/n*100;
    bprob = bwin/n*100;
    fprintf('Ann''s winning probability with %5d simulations: %07.4f%%.\n', ...
        n, aprob);
    fprintf('Bob''s winning probability with %5d simulations: %07.4f%%.\n', ...
        n, bprob);
end

acalp = ptail^2*(1-2*ptail*(1-ptail))*100;
bcalp = 2*ptail*(1-ptail)*(1-ptail^2)*100;
fprintf('Ann''s calculated winning probability:             %07.4f%%.\n', ...
    acalp);
fprintf('Bob''s calculated winning probability:             %07.4f%%.\n', ...
    bcalp);
