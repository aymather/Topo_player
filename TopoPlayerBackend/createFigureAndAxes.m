% Create a figure window and two axes with titles to display two videos.
function [hFig, hAxes] = createFigureAndAxes(settings)

    % Init frame counter
    global framenum;

    % Close figure opened by last run
    figTag = 'Video_Figure';
    close(findobj('tag',figTag));

    % Create new figure
    hFig = figure('numbertitle', 'off', ...
           'name', 'Topo_Player', ...
           'menubar','none', ...
           'toolbar','none', ...
           'resize', 'on', ...
           'tag',figTag, ...
           'renderer','painters', ...
           'Color','w',...
           'Visible',settings.displayMode, ...
           'position',settings.screen.owd);

    % Create movie axes
    [hAxes.axis1, hAxes.ui1] = createPanelAxisTitle(hFig,settings.positions.movie,['Time Lapsed ' num2str(frame2time(settings,framenum)) 'ms']); 
    
    % Sort the fieldnames and place it into an array
    if isfield(settings,'display')
        fnames = fieldnames(settings.display);
        b = [];
        for it = 1:length(fnames)
            b = [b, str2double(strip_it(fnames{it}))];
        end
        sorted = sort(b);
        
        % Place axes on GUI
        if length(fnames) > 1
            for i = 1:length(fnames)
                pos = settings.positions.cframes(i,:); % get position of frame
                title = settings.display.(['d' num2str(sorted(i))]).title;
                [hAxes.(['axis' num2str(sorted(i))]), hAxes.(['ui' num2str(sorted(i))])] = createPanelAxisTitle(gcf, pos, title);
            end
        else
            [hAxes.(['axis' num2str(sorted(1))]),hAxes.(['ui' num2str(sorted(1))])] = createPanelAxisTitle(gcf,settings.positions.cframes, settings.display.(['d' num2str(sorted(1))]).title);
        end
    end
    
    % Add Progress bar with axes
    hAxes.pBar = uiProgressBar(settings,hFig);
    
end