function [prize, amount] = checkPrize(ticketNum, jackpotNum)
% Determine what prize you win given a ticket and the jackpot numbers.
% prize is 0 for grand prize, 1 for first prize, 2 for second p rize, 3 for
% third prize, and 4 for no prize.
% amount is the amount of money gained by this ticket (e.g. 2 for third
% prize).
% ticketNum and jackpotNum are 1d arrays, each of which consists of four
% random integers in [0, 9].
% ticketNum represents the numbers on a lottery ticket.
% jackpotNum represents the numbers that win the grand prize.
%
% Record of revisions:
%     Date        Programmer      Description of change
%     ====        ==========      =====================
%   06/10/16      Alice Chen          Original code

% nmatch is the number of matching numbers between ticketNum and jackpotNum
nmatch = 0;
for k = 1:4
    if ticketNum(k) == jackpotNum(k)
        nmatch = nmatch + 1;
    end
end

% nmatch    = [0 1  2   3    4], correspondingly
% subscript = [1 2  3   4    5], correspondingly
parray      = [4 3  2   1    0];
aarray      = [0 2 10 100 5000];

prize = parray(nmatch+1);
amount = aarray(nmatch+1);