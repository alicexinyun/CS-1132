function [result, n] = myLn(x, threshold)
% Estimate ln(1+x) sing Taylor series.
% x is a number in (0, 1).
% result is the estimated ln(1+x).
% n is the smallest number of terms used in the Taylor series such that the
% error of the approximation is strictly below threshold.
%
% Record of revisions:
%     Date        Programmer      Description of change
%     ====        ==========      =====================
%   06/12/16      Alice Chen          Original code

result = 0;
n = 0;
while x^(n+1)/(n+1) > threshold
    n = n + 1;
    result = result + (-1)^(n+1)*x^n/n;
end