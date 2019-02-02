clear

%% Test scenario 0
% 
% Given a game of life
% When there are no live cells
% Then on the next step there are still no live cells

% seedArray with no live cells
seedArray = zeros(10,10);
% required result - no live cells
reqArray = zeros(10,10);

% run the engine
outArray = gameOfLife(seedArray);

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
                
% required result in all cases - no live cells
reqArray = zeros(3,3);

% run the engine and check each output
success_tally = zeros(length(seedArray),1);
for t = 1:length(seedArray)
    outArray = gameOfLife(seedArray{t});
    if isequal(outArray,reqArray)
        success_tally(t) = 1;
    end
end

% Report result. If any examples are failed, return which ones.
if all(success_tally)
    display('Passed test scenario 1');
else
    display(['FAILED test scenario 1. Failed examples ' num2str(find(~success_tally)) '.']);
end

