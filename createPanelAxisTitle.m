% Create Axis and Title
% Axis is created on uipanel container object. This allows more control
% over the layout of the GUI. Video title is created using uicontrol.
function [hAxis, ui] = createPanelAxisTitle(hFig, pos, axisTitle)

    % Create panel
    hPanel = uipanel('parent',hFig, ...
        'Position',pos, ... 
        'Units','Normalized', ...
        'BorderType','none');
    
    % Get current color to match background
    figColor = get(gcf,'Color');

    % Create axis   
    hAxis = axes('position',[0 0 1 1],'Parent',hPanel); 
    hAxis.XTick = [];
    hAxis.YTick = [];
    hAxis.XColor = figColor;
    hAxis.YColor = figColor;
    
    % Set video title using uicontrol. uicontrol is used so that text
    % can be positioned in the context of the figure, not the axis.
    titlePos = [pos(1)-.005 pos(2)-0.1 pos(3) .09];
    ui = uicontrol('style','text',...
        'String', axisTitle,...
        'Units','Normalized',...
        'Parent',hFig,...
        'Position', titlePos,...
        'BackgroundColor',hFig.Color);

end