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


