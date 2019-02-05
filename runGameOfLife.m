function outArray = runGameOfLife(seedArray, numSteps, displayOptions)
%runGameOfLife: Performs specified number of steps in Game of Life, using
%specified seed
%
% INPUT
% seedArray - 2D matrix (0 for dead cells, 1 for live cells)
% numSteps - positive integer, number of game steps to perform
% displayOptions - string - 'continuous' displays progress of game
%       frame-by-frame, any other value gives no display
% OUTPUT
% outArray - 2D matrix (0 for dead cells, 1 for live cells)
%
% BT, Feb 2019



% initialise
currentArray = seedArray;

if strcmp(displayOptions, 'continuous')
    dispFig = figure;
    ax = axes;
    % draw grid 
    im = image(currentArray, 'CDataMapping', 'scaled', 'Visible', 'off');
    formatDisplay(ax, size(currentArray));
    im.Visible = 'on';
end
    
%run steps
for s=1:numSteps
    if strcmp(displayOptions, 'continuous')
        % pause so each step is visible
        pause(0.5)
    end
    currentArray = gameOfLife(currentArray);
    if strcmp(displayOptions, 'continuous')
        % CData - draw on the axes retaining existing formatting
        image('CData', currentArray, 'CDataMapping', 'scaled')
    end
end

%assign output
outArray = currentArray;

end

function formatDisplay(ax, siz)
% format the display appearance appropriately

% set extent of axes to the limits of the array, and scale of both the same
ax.DataAspectRatio = [1 1 1];
ax.XLim =  0.5 + [ 0 siz(2) ];
ax.YLim =  0.5 + [ 0 siz(1) ];

% display lines between cells, no numbering
ax.YTick = 0.5 : 1 : siz(1)+0.5 ;
ax.YTickLabel = '';
ax.XTick = 0.5 : 1 : siz(2)+0.5 ;
ax.XTickLabel = '';
ax.TickLength = [0 0];
grid on

% set white/blue colormap for cells: 0=dead=white and 1=live=blue
colmap = [1 1 1; 0 0 1];
colormap(colmap);
caxis([0 1])
end


