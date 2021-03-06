%% Test scenario 0
% 
% Given a game of life
% When there are no live cells
% Then on the next step there are still no live cells

clear

% seedArray with no live cells
seedArray = zeros(10,10);
% required result - no live cells
reqArray = zeros(10,10);

% run the engine
outArray = gameOfLife(seedArray, []);

% check output
if isequal(outArray,reqArray)
    display('Passed test scenario 0');
else
    display('FAILED test scenario 0');
end

%% Test scenario 1: Underpopulation
% 
% Given a game of life
% When a live cell has fewer than two neighbours
% Then this cell dies

clear

% test some examples of this case:

% live cell has no neighbours
seedArray{1} =  [   0     0     0;
                    0     1     0;
                    0     0     0];
% live cell has 1 neighbour - some different positions
seedArray{2} =  [   0     0     0;
                    1     1     0;
                    0     0     0];
seedArray{3} =  [   0     1     0;
                    0     1     0;
                    0     0     0];
seedArray{4} =  [   0     0     0;
                    0     1     0;
                    0     0     1];
                
% required result in all cases - central cell dies
% run the engine and check each output - only need to check central cell
success_tally = zeros(1, length(seedArray));
for t = 1:length(seedArray)
    outArray = gameOfLife(seedArray{t}, []);
    if outArray(3,3) == 0
        success_tally(t) = 1;
    end
end

% Report result. If any examples are failed, return which ones.
if all(success_tally)
    display('Passed test scenario 1');
else
    display(['FAILED test scenario 1. Failed examples ' num2str(find(~success_tally)) '.']);
end

%% Test scenario 2: Overcrowding
% Given a game of life
% When a live cell has more than three neighbours
% Then this cell dies

clear

% some different overcrowding distributions around central cell in array
seedArray{1} =  [   0   0   0   0   0;
                    0   1   1   1   0;
                    0   0   1   1   0;
                    0   0   0   0   0;
                    0   0   0   0   0   ];
seedArray{2} =  [   0   0   0   0   0;
                    0   1   1   0   0;
                    0   0   1   1   0;
                    0   0   1   0   0;
                    0   0   0   0   0];
seedArray{3} =  [   0   0   0   0   0;
                    0   1   1   1   0;
                    0   0   1   1   0;
                    0   1   1   1   0;
                    0   0   0   0   0   ];
seedArray{4} =  [   0   0   0   0   0;
                    0   1   0   1   0;
                    0   0   1   0   0;
                    0   0   1   1   0;
                    0   0   0   0   0   ];

% run the engine and check each output - only need to check central cell
success_tally = zeros(1, length(seedArray));
for t = 1:length(seedArray)
    outArray = gameOfLife(seedArray{t}, []);
    if outArray(3,3) == 0
        success_tally(t) = 1;
    end
end

% Report result. If any examples are failed, return which ones.
if all(success_tally)
    display('Passed test scenario 2');
else
    display(['FAILED test scenario 2. Failed examples ' num2str(find(~success_tally)) '.']);
end

%% Test scenario 3: Survival
% Given a game of life
% When a live cell has two or three neighbours
% Then this cell stays alive


clear

% some different 2-3 neighbour distributions around central cell in array
seedArray{1} =  [   0   0   0   0   0;
                    0   1   1   0   0;
                    0   0   1   1   0;
                    0   0   0   0   0;
                    0   0   0   0   0   ];
seedArray{2} =  [   0   0   0   0   0;
                    0   0   0   0   0;
                    0   0   1   1   0;
                    0   0   1   0   0;
                    0   0   0   0   0];
seedArray{3} =  [   0   0   0   0   0;
                    0   0   0   1   0;
                    0   0   1   0   0;
                    0   1   0   1   0;
                    0   0   0   0   0   ];
seedArray{4} =  [   0   0   0   0   0;
                    0   1   0   0   0;
                    0   0   1   0   0;
                    0   0   1   1   0;
                    0   0   0   0   0   ];
seedArray{5} =  [   0   0   0   0   0;
                    0   1   0   0   0;
                    0   0   1   0   0;
                    0   0   0   1   0;
                    0   0   0   0   0   ];
seedArray{6} =  [   0   0   0   0   0;
                    0   0   0   0   0;
                    0   0   1   0   0;
                    0   1   1   0   0;
                    0   0   0   0   0   ];
                
% run the engine and check each output - only need to check central cell
success_tally = zeros(1, length(seedArray));
for t = 1:length(seedArray)
    outArray = gameOfLife(seedArray{t}, []);
    if outArray(3,3) == 1
        success_tally(t) = 1;
    end
end

% Report result. If any examples are failed, return which ones.
if all(success_tally)
    display('Passed test scenario 3');
else
    display(['FAILED test scenario 3. Failed examples ' num2str(find(~success_tally)) '.']);
end

%% Test scenario 4: Creation of Life
% Given a game of life
% When an empty position has exactly three neighbouring cells
% Then a cell is created in this position

clear

% some different 3-neighbour distributions around empty central cell in array
seedArray{1} =  [   0   0   0   0   0;
                    0   1   1   0   0;
                    0   0   0   1   0;
                    0   0   0   0   0;
                    0   0   0   0   0   ];
                
seedArray{2} =  [   0   0   0   0   0;
                    0   1   0   0   0;
                    0   0   0   1   0;
                    0   0   1   0   0;
                    0   0   0   0   0];
                
seedArray{3} =  [   0   0   0   0   0;
                    0   0   0   1   0;
                    0   0   0   0   0;
                    0   1   0   1   0;
                    0   0   0   0   0   ];
                
seedArray{4} =  [   0   0   0   0   0;
                    0   1   0   0   0;
                    0   0   0   0   0;
                    0   0   1   1   0;
                    0   0   0   0   0   ];
                
seedArray{5} =  [   0   0   0   0   0;
                    0   1   0   0   0;
                    0   1   0   0   0;
                    0   1   0   0   0;
                    0   0   0   0   0   ];
                
seedArray{6} =  [   0   0   0   0   0;
                    0   0   0   0   0;
                    0   1   0   0   0;
                    0   1   1   0   0;
                    0   0   0   0   0   ];
                
% run the engine and check each output - only need to check central cell
success_tally = zeros(1, length(seedArray));
for t = 1:length(seedArray)
    outArray = gameOfLife(seedArray{t}, []);
    if outArray(3,3) == 1
        success_tally(t) = 1;
    end
end

% Report result. If any examples are failed, return which ones.
if all(success_tally)
    display('Passed test scenario 4');
else
    display(['FAILED test scenario 4. Failed examples ' num2str(find(~success_tally)) '.']);
end
                
%% Test scenario 5: Grid with no live cells
% Given a game of life with the initial state containing no live cells
% When the game evolves one turn
% Then the next state also contains no live cells

clear

% check some randomly sized arrays between 1 and 1000 with no live cells
arraySizes = round(1000*rand(10,1));
success_tally = zeros(1, length(arraySizes));

for s = 1:length(arraySizes)
    siz = arraySizes(s);
    seedArray = zeros(siz,siz);
    % required result - same size, no live cells
    reqArray = seedArray;
    
    % run the engine
    outArray = gameOfLife(seedArray, []);

    % check output
    if isequal(outArray,reqArray)
        success_tally(s) = 1;
    end
end

% Report result. If any examples are failed, return which ones.
if all(success_tally)
    display('Passed test scenario 5');
else
    display(['FAILED test scenario 5. Failed examples ' num2str(find(~success_tally)) '.']);
end
         
%% Scenario 6: Expected game outcome for seeded grid

clear

% expected sequence as follows
seedArray =     [   0   0   0   0   0;
                    0   0   0   0   0;
                    0   1   1   1   0;
                    0   0   0   0   0;
                    0   0   0   0   0   ];
reqArray{1} =     [ 0   0   0   0   0;
                    0   0   1   0   0;
                    0   0   1   0   0;
                    0   0   1   0   0;
                    0   0   0   0   0   ];
reqArray{2} =     [ 0   0   0   0   0;
                    0   0   0   0   0;
                    0   1   1   1   0;
                    0   0   0   0   0;
                    0   0   0   0   0   ];

%initialise
currentArray = seedArray;    
% run the engine and check each output - only need to check central cell
success_tally = zeros(1, 2);
for s = 1:2
    currentArray = gameOfLife(currentArray, []);
    if isequal(currentArray,reqArray{s})
        success_tally(s) = 1;
    end
end

% Report result. If any any steps give the wrong state, return which ones.
if all(success_tally)
    display('Passed test scenario 6');
else
    display(['FAILED test scenario 6. Incorrect states after step(s) ' num2str(find(~success_tally)) '.']);
end
                
