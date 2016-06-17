function [r, c] = pickNewPosition(board, color)
% This function finds a legal position to place a new disk such that the
% number of reversed disks is maximized. If multiple positions have the
% same maximum number, pick the one that occurs first when sweeping the matrix.
% board is the state of the board before placing the disk.
% color is 0 for black disk and 1 for white disk.
% The new disk is placed at board(r, c).
% If there is no legal position, r = 0 and c = 0.
%
% Record of revisions:
%     Date        Programmer      Description of change
%     ====        ==========      =====================
%   06/12/16      Alice Chen          Original code

n = size(board, 1);
maxR = 0;
% Sweep the matrix row by row from top left to bottom right.
for rnum = 1:n
    for cnum = 1:n
        if board(rnum, cnum) == -1
            [~, numR] = placeNewDisk(board, rnum, cnum, color);
            if numR > maxR
                maxR = numR;
                r = rnum;
                c = cnum;
            end
        end
    end
end

if maxR == 0
    r = 0;
    c = 0;
end
