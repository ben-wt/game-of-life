function outArray = gameOfLife(seedArray)

% Performs 1 step in Game of Life
%
% INPUT
% seedArray - 2D matrix (0 for dead cells, 1 for live cells)
% OUTPUT
% outArray - 2D matrix (0 for dead cells, 1 for live cells)
%
% BT, Feb 2019

% scenario 0 - check if no live cells, then no change
if isequal(seedArray, zeros(size(seedArray)))
    outArray = seedArray;
end
end