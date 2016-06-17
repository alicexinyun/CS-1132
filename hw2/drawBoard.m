function drawBoard(m)
% Draw the state of board in the Reversi game.
% m is an n-by-n matrix representing the state of the board.
% m(1, 1) is at the top left (northwest corner).
% m(n, n) is at the bottom right (southeast corner).
cla
hold on
n = size(m, 1);
for r= 1:n
    for c= 1:n
        if m(r,c)==1
            plot(c,n+1-r,'.','Color','w','Markersize',50);
        elseif m(r,c) == 0
            plot(c,n+1-r,'.','Color','k','Markersize',50);   
        end
    end
end
for i = 0:n
    plot([0.5, n+0.5], [i+0.5, i+0.5], 'Color', 'k');
    plot([i+0.5, i+0.5], [0.5, n+0.5], 'Color', 'k');
end

hold off