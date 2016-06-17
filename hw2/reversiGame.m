function reversiGame()
% An interactive Reversi game.
% The user can left click the mouse to place a black disk or right click
% the mouse to temporarily see the board state after placing a black disk
% at that position. The white disks are placed by an AI player with a
% greedy strategy. Whenever there is no legal position for a certain color,
% the corresponding player's turn is skipped. The game ends when no disk
% can be legally placed on the board. The player who has more disks of
% his/her color on the board wins the game.
%
% Record of revisions:
%     Date        Programmer      Description of change
%     ====        ==========      =====================
%   06/15/16      Alice Chen          Original code

%%initialize the board
board = -ones(8, 8);
board(4, 4) = 1; % white AI
board(5, 5) = 1;
board(4, 5) = 0; % black user
board(5, 4) = 0;

%%initialize the figure for drawing
close all
figure
axis equal off
ylim([0.5 8.5]);
xlim([0.5 8.5]);
set(gca,'Color',[0.5 0.5 0.5]);

color = 0;
gameState = 'Black''s turn!';
nFailure = 0;
gameEnd = false;
title({wkNum(board), '', gameState}, 'FontSize', 18)
drawBoard(board);

%%game loop
pauseTime = 0.5;
while ~gameEnd 
    drawnow;
    pause(pauseTime);
    % Game continues
    if color == 0
        [r, c] = pickNewPosition(board, 0);
        % Black's turn (there exists some legal position)
        if r > 0 && c > 0
            gameState = 'Black''s turn!';
            title({wkNum(board), '', gameState}, 'FontSize', 18);
            [x, y, b] = ginput(1);
            r = 8+1-round(y);
            c = round(x);
            [newBoard, numReversed] = placeNewDisk(board, r, c, 0);
            if b == 1 % left click
                if numReversed ~= 0 % legal position
                    board = newBoard;
                    title({wkNum(board), revNum(numReversed), ...
                        gameState}, 'FontSize', 18);
                    nFailure = 0;
                    color = 1;
                else % illegal position
                    hold on;
                    plot(c, 8+1-r, 'rx', 'LineWidth', 10, 'MarkerSize', 20);
                    title({wkNum(board), 'Click illegal!', gameState}, 'FontSize', 18);
                    pause(pauseTime);
                    hold off;
                end
            elseif b == 3 % right click
                if numReversed ~= 0 % legal position
                    title({wkNum(newBoard), revNum(numReversed), ...
                        gameState}, 'FontSize', 18);
                    drawBoard(newBoard);
                    pause(pauseTime);
                else % illegal position
                    hold on;
                    plot(c, 8+1-r, 'rx', 'LineWidth', 10, 'MarkerSize', 20);
                    title({wkNum(board), 'Click illegal!', gameState}, 'FontSize', 18);
                    pause(pauseTime);
                    hold off;
                end                
            end
        % Black's turn skipped
        else
            gameState = 'Black''s turn skipped!';
            title({wkNum(board), '', gameState}, 'FontSize', 18)
            pause(pauseTime);
            nFailure = nFailure + 1;
            color = 1;
        end
        %loopEnd = true;
    elseif color == 1
        [r, c] = pickNewPosition(board, 1);
        % White's turn (there exists some legal position)
        if r > 0 && c > 0
            gameState = 'White''s turn!';
            [newBoard, numReversed] = placeNewDisk(board, r, c, 1);
            title({wkNum(newBoard), revNum(numReversed), gameState}, ...
                'FontSize', 18);
            % twinkle
            drawBoard(newBoard); pause(0.1);
            drawBoard(board); pause(0.1);
            drawBoard(newBoard); pause(0.1);
            board = newBoard;
            nFailure = 0;
            color = 0;
        % White's turn skipped
        else
            gameState = 'White''s turn skipped!';
            title({wkNum(board), '', gameState}, 'FontSize', 18)
            pause(pauseTime);
            nFailure = nFailure + 1;
            color = 0;
        end
    end
    drawBoard(board);
    % Game over
    if nFailure == 2
        gameEnd = true;
    end
end

%%game result
[w, k] = getWK(board);
if w > k
    winner = 'white AI';
elseif w < k
    winner = 'black user';
else
    winner = 'neither';
end
gameState = sprintf('Game over; %s wins!', winner);
title({wkNum(board), '', gameState}, 'FontSize', 18)


function title1 = wkNum(board)
% Get and format current white and black disk numbers to a string.
[w, k] = getWK(board);
title1 = sprintf('%d whites, %d blacks.', w, k);


function [w, k] = getWK(board)
% Get current white and black disk numbers.
w = sum(sum(board == 1));
k = sum(sum(board == 0));


function title2 = revNum(numReversed)
% Format number of disks reversed to a string.
title2 = sprintf('Number reversed: %d.', numReversed);
