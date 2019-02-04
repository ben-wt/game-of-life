function outArray = runGameOfLife(seedArray, numSteps)
%runGameOfLife: Performs specified number of steps in Game of Life, using
%specified seed
%
% INPUT
% seedArray - 2D matrix (0 for dead cells, 1 for live cells)
% numSteps - positive integer, number of game steps to perform
% OUTPUT
% outArray - 2D matrix (0 for dead cells, 1 for live cells)
%
% BT, Feb 2019

% initialise
currentArray = seedArray;

%run steps
for s=1:numSteps
    currentArray = gameOfLife(currentArray);
end

%assign output
outArray = currentArray;

end

