function retrieveContactInfo(inputFile, outputFile)
% A contact information retrieval system. This function reads the contact
% information from a text file and saves the query log to another text file.
% The user can enter the name to query the information of a contact, or
% enter ':q' to quit the system. If the input name matched some contacts in
% the data, the information of all matched contacts is printed. Otherwise
% the system finds contacts who have similar names and print their information.
% inputFile: name of input text file containing the contact infomation.
% outputFile: name of the output query log file.
%
% Record of revisions:
%     Date        Programmer      Description of change
%     ====        ==========      =====================
%   06/14/16      Alice Chen          Original code

systemQuit = false;
array = [];
data = readContactFile(inputFile);
while ~systemQuit
    name = input('Please enter the contact name (or :q to quit): ', 's');
    c = clock;
    if strcmpi(name, ':q')
        array2File(array, outputFile)
        systemQuit = true;
    else
        % time: an integer array with the format [year month day hr min sec].
        time = fix(c);
        % log: a piece of query history with the format [mm/dd/yyyy hh:mm:ss name\n].
        log = sprintf('%02d/%02d/%04d %02d:%02d:%02d %s\n', ...
            time(2), time(3), time(1), time(4), time(5), time(6), name);
        array = [array log];
        exactNotFound = true;
        for i = 1:size(data, 2)
            if strcmpi(name, data{i}{1})
                if exactNotFound
                    fprintf('%s''s contact info (each line is a different %s):\n', ...
                        name, name)
                    exactNotFound = false;
                end
                display(myStrJoin(data{i}(2:length(data{i})), ', '))
            end
        end
        if exactNotFound
            fprintf('Exact name not found.\n')
            % Find and print (if any) similar contacts with less than 3 
            % Levenshtein distance from the queried string.
            similarNotFound = true;
            for i = 1:size(data, 2)
                if strDist(name, data{i}{1}) < 3
                    if similarNotFound
                        fprintf('Contact info for names similar to %s:\n', name)
                        similarNotFound = false;
                    end
                    display(myStrJoin(data{i}, ', '))
                end
            end
            if similarNotFound
                fprintf('Similar name not found, either. :(\n')
            end
        end
    end
end


function data = readContactFile(fn)
% Read contact information from file.
% fn: the input file name.
% data: information of all contacts, a 1-d cell array of cell arrays, where
%   data{i}{1} is the name of the ith contact,
%   data{i}{2}, if it exists, is additional info of the contact,
%   data{i}{3}, if it exists, is additional info of the contact,
% ..., etc.

fid = fopen(fn, 'r');
i = 0;
while ~feof(fid)
    i = i+1;
    data{i} = splitString(fgetl(fid));
end
fclose(fid);


function data = splitString(str)
% Split a line of string into substrings. Two neighboring substrings are
% separated by ?; ? (a semicolon followed by a space).
% str: the string to be split.
% data: a 1-d cell array in which each cell is a substring. The separators
% are not included.

indices = myStrFind(str, '; ');
n = length(indices)+1;
data = cell(1, n);
data{1} = str(1:indices(1)-1);
data{n} = str(indices(n-1)+2:length(str));
for i = 2:n-1
    data{i} = str(indices(i-1)+2:indices(i)-1);
end


function indices = myStrFind(str, pattern)
% Find a substring within another string.
% str: an input string.
% pattern: the substring to be found in str.
% indices: the returned 1-d array, which is the starting indices of any
% occurences of the string pattern in the string str.

indices = [];
n = length(str);
m = length(pattern);
for i = 1:n-m+1
    if strcmp(str(i:i+m-1), pattern)
        indices = [indices i];
    end
end


function res = myStrJoin(cell, str)
% Join the elements in cell with str in between.
% cell: a 1-d cell array of strings.
% str: the string to add between the strings in cell.
% res: the returned string.

n = length(cell);
res = [];
for i = 1:n-1
    res = [res cell{i} str];
end
res = [res cell{n}];


function array2File(array, fn)
% Write the query history in array to fn.
% array: a 1-d array of strings with the format [mm/dd/yyyy hh:mm:ss name\n].
% fn: name of the file.

fid = fopen(fn, 'w');
for i = 1:length(array)
    fprintf(fid, array(i));
end
fclose(fid);
