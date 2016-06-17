% Script plotResidual.m
%
% Record of revisions:
%     Date        Programmer      Description of change
%     ====        ==========      =====================
%   06/12/16      Alice Chen          Original code

figure
hold on

n = 1:25; % number of terms
for x = [.2 .5 .8]
    r = x.^(n+1)./(n+1); % upper bound of the residual
    plot(n, r)
end
legend('x=.2', 'x=.5', 'x=.8')
title('Upper bound of the residual vs. number of terms for different x''s')
xlabel('number of terms')
ylabel('upper bound of the residual')
hold off

figure
hold on

x = 0.01:0.01:0.99; % value of x
r = x.^(5+1)./(5+1); % upper bound of the residual
plot(x, r)

title('Upper bound of the residual vs. x when there are 5 terms')
xlabel('value of x')
ylabel('upper bound of the residual')
hold off
