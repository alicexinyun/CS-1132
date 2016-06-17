function result = randTicketNumbers()
% Returns a 1d array that consists of four random integers in [0, 9],
% representing the numbers on a lottery ticket.
%
% Record of revisions:
%     Date        Programmer      Description of change
%     ====        ==========      =====================
%   06/10/16      Alice Chen          Original code

result = zeros(1,4);
for k = 1:4
    result(k) = myRandInt(0,9);
end
