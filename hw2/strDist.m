function dist = strDist(str1, str2)
% The Levenshtein distance between two strings, which is the minimum number
% of single-character edits (insertions, deletions or substitutions) needed
% to change one string into the other.
% str1: input string 1.
% str2: input string 2.
% dist: Levenshtein distance.

    if isempty(str1)
        dist = length(str2);
    elseif isempty(str2)
        dist = length(str1);
    else
        if str1(length(str1)) == str2(length(str2))
            cost = 0;
        else
            cost = 1;
        end
        
        dist = min(min(strDist(str1(1:length(str1)-1), str2) + 1,...
                   strDist(str1, str2(1:length(str2)-1)) + 1),... 
                   strDist(str1(1:length(str1)-1), str2(1:length(str2)-1)) + cost);
        
    end
end