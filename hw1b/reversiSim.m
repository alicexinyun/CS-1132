% Script: reversiSim.m
%
% Record of revisions:
%     Date        Programmer      Description of change
%     ====        ==========      =====================
%   06/12/16      Alice Chen          Original code

% Perfect for checking: http://www.2player.com/skill-games/reversi.html

%%initialize the board
board = -ones(8, 8);
board(4, 4) = 1;
board(5, 5) = 1;
board(4, 5) = 0;
board(5, 4) = 0;

%%initialize the figure for drawing
close all
figure
axis equal off
ylim([0.5 8.5]);
xlim([0.5 8.5]);
set(gca,'Color',[0.5 0.5 0.5]);

drawBoard(board);
gameEnd = false;
color = 0;
nFailure = 0;
pauseTime = 0.2;
%%game loop
while ~gameEnd 
    drawnow;    
    pause(pauseTime); % Checking: pause; % Pause until key press
    [r, c] = pickNewPosition(board, color);
    if r>0 && c>0
        board = placeNewDisk(board, r, c, color);        
        nFailure = 0;
    else
        nFailure = nFailure + 1; 
    end  
    drawBoard(board);
    color = 1 - color;
    if nFailure == 2
        gameEnd = true;
    end
end

%%game result
k = 0;
w = 0;
n = size(board, 1);
for rnum = 1:n
    for cnum = 1:n
        if board(rnum, cnum) == 0
            k = k+1;
        elseif board(rnum, cnum) == 1
            w = w+1;
        end
    end
end

if w > k
    winner = 'White';
elseif w < k
    winner = 'Black';
else
    winner = 'Neither';
end

title(sprintf('%d whites; %d blacks. %s wins.', w, k, winner), ...
    'FontSize', 18); % 45 whites; 19 blacks. White wins.