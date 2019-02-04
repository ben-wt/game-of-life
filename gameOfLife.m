function outArray = gameOfLife(seedArray)

% Performs 1 step in Game of Life
%
% INPUT
% seedArray - 2D matrix (0 for dead cells, 1 for live cells)
% OUTPUT
% outArray - 2D matrix (0 for dead cells, 1 for live cells)
%
% BT, Feb 2019

% use convolution to count the number of live neighbours for every cell
neighboursKernel = [1 1 1 ; 1 0 1; 1 1 1];
numNeighbours = conv2(seedArray, neighboursKernel, 'same');

% cells in output are live where:
% (they were live before AND had at least 2 neighbours AND had no more than 3 neighbours)
% OR
% (they were dead before AND have exactly 3 neighbours)
outArray = (seedArray & numNeighbours >= 2 & numNeighbours <= 3)...
            | (~seedArray & numNeighbours == 3);
end