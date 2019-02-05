function outArray = gameOfLife(seedArray, worldType)

% Performs 1 step in Game of Life
%
% INPUT
% seedArray - 2D matrix (0 for dead cells, 1 for live cells)
% worldType - string
%                   - 'torus' game world wraps around on itself to be
%                       boundless (default value if empty or unrecognised
%                       input)
%                   - 'finite' game world is finite, bounded grid
%
% OUTPUT
% outArray - 2D matrix (0 for dead cells, 1 for live cells)
%
% BT, Feb 2019

%% check inputs are appropriate variable types

% seedArray should be a 2D matrix, class 'double'
if ~ismatrix(seedArray) || ~isa(seedArray,'double')
    error('seedArray input to gameOfLife must be a 2D matrix with double-precision number format')
end

% default - if world type is left empty, or unrecognised, set to torus
possible_worldTypes = {'torus', 'finite'};
if isempty(worldType) || all(~strcmp(worldType, possible_worldTypes))
    worldType = 'torus';
end

%% run the step

% if 'torus', pad the array and copy edges across for 'wrap around' effect
if strcmp(worldType,'torus')
    seedArray = wrappad(seedArray);
end

% use convolution to count the number of live neighbours for every cell
neighboursKernel = [1 1 1 ; 1 0 1; 1 1 1];
numNeighbours = conv2(seedArray, neighboursKernel, 'same');

% if 'torus', crop arrays back down to original size
if strcmp(worldType,'torus')
    seedArray = seedArray( 2:end-1 , 2:end-1 );
    numNeighbours = numNeighbours( 2:end-1 , 2:end-1 );
end

% cells in output are live where:
% (they were live before AND had at least 2 neighbours AND had no more than 3 neighbours)
% OR
% (they were dead before AND have exactly 3 neighbours)
% and set the output to standard number format (double-precision) so it can be fed back in
outArray = double((seedArray & numNeighbours >= 2 & numNeighbours <= 3)...
            | (~seedArray & numNeighbours == 3));
end

function A2 = wrappad(A1)
% pad the array and copy edges across for 'wrap around' effect

% create array copy padded with zeros
A2 = padarray(A1,[1 1]);

% pad each edge by copying opposite edge
A2(2:end-1,1) = A1(:,end);
A2(2:end-1,end) = A1(:,1);
A2(1, 2:end-1) = A1(end,:);
A2(end, 2:end-1) = A1(1,:);

% copy opposite corners
A2(1,1) = A1(end,end);
A2(1,end) = A1(end,1);
A2(end,1) = A1(1,end);
A2(end,end) = A1(1,1);

end
    

