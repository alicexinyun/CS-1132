function [newBoard, numReversed] = placeNewDisk(board, r, c, color)
% Try placing a new disk at a given position
% board is an n-by-n matrix representing the state of the board before
% placing the disk.
% Attempt to place the new disk at board(r, c). r is the row number and c
% is the column number. In drawBoard(), r increases going south and c
% increases going east.
% color = 0 when we try to place a black disk. color = 1 for a white disk.
% newBoard is the state of the board after placing the new disk.
% numReversed is the number of disks reversed after placing the new disk.
% If (r, c) is not a legal position, newBoard = board and numReversed = 0.
%
% Record of revisions:
%     Date        Programmer      Description of change
%     ====        ==========      =====================
%   06/12/16      Alice Chen          Original code

numReversed = 0;
newBoard = board;
if newBoard(r, c) == -1 % property 1 for the position to be legal
    for xi = -1:1
        for yi = -1:1
            % if xi=0 and yi=0, incr is simply 0
            incr = countReversed(board, r, c, color, xi, yi);
            numReversed = numReversed + incr;
            for k = 1:incr
                newBoard(r+k*xi, c+k*yi) = color;
            end
        end
    end
    if numReversed ~= 0 % property 2 for the position to be legal
        newBoard(r, c) = color;
    end
end


function numReversed = countReversed(board, r, c, color, xi, yi)
% Count the number of reversed disks along a particular direction after
% placing a new disk.
% board, r, c, color have the same meaning as in placeNewDisk.
% xi and yi indicate the direction. e.g. xi=1 and yi=1 means that we are
% counting along the half-line in the southeast direction.
% numReversed is the number of reversed disks along this direction.

n = size(board, 1);
k = 0;
while 1 <= r+xi && r+xi <= n && 1 <= c+yi && c+yi <= n && ...
        board(r+xi, c+yi) == 1 - color
    r = r+xi;
    c = c+yi;
    k = k+1;
end

if 1 <= r+xi && r+xi <= n && 1 <= c+yi && c+yi <= n && ...
        board(r+xi, c+yi) == color
    numReversed = k;
else
    numReversed = 0;
end
