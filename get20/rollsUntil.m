function n = rollsUntil(p)
% Simulates the rolling of a die several times until p points have been
% accumulated and returns the required number of rolls.
%
% Record of revisions:
%     Date        Programmer      Description of change
%     ====        ==========      =====================
%   06/09/16      Alice Chen          Original code

points = 0; n = 0;
    while points < p
        point = randi([1 6]); % result of one roll
        points = points + point; % cumulative result of all previous rolls
        n = n + 1;
    end