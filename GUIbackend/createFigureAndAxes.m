% Create a figure window and two axes with titles to display two videos.
function [hFig, hAxes] = createFigureAndAxes(settings)

    % Init frame counter
    global framenum;

    % Close figure opened by last run
    figTag = 'Video_Figure';
    close(findobj('tag',figTag));

    % Create new figure
    hFig = figure('numbertitle', 'off', ...
           'name', 'Topo Player', ...
           'menubar','none', ...
           'toolbar','none', ...
           'resize', 'on', ...
           'tag',figTag, ...
           'renderer','painters', ...
           'Color','w',...
           'position',settings.screen.owd);

    % Create axes and titles [X Y W H]
    numframes = length(fieldnames(settings.display)); % how many frames are we going to capture?
    movieW = 17/60; movieH = 27/60;
    hsub = .05; wsub = ((1/3)/10); h = .5; w = 1/3;
    if numframes == 1 % if we're only capturing 1 frame, go horizontal to save space
        movieX = (1/6); movieY = 1/4; % movie adjustments
        cframeX = (3/6)+.1; cframeY = 1/4;
    else
        movieX = 21/60; movieY = 33/60; % movie adjustments
        h = h - (hsub*numframes);
        w = w - (wsub*numframes);
        y = (.5/2) - (h/2);
        xpos = [];
        for i = 1:numframes
            x = (i)/(numframes+1);
            x = x-(w/2);
            xpos = [xpos;x];
        end
    end 
    movieSize = [movieX movieY movieW movieH];
    [hAxes.axis1, hAxes.ui1] = createPanelAxisTitle(hFig,movieSize,['Frame ' num2str(framenum) ' : Time Lapsed ' num2str(frame2time(settings.srate,framenum)) 'ms']); 
    
    % Sort the fieldnames and place it into an array
    fnames = fieldnames(settings.display);
    b = [];
    for it = 1:numframes
        b = [b, str2double(strip(fnames{it},'left','d'))];
    end
    sorted = sort(b);
    
    % Place axes on GUI
    if numframes > 1
        for i = 1:length(fnames)
            pos = [xpos(i) y w h]; % get position of frame
            title = settings.display.(['d' num2str(sorted(i))]).title;
            [hAxes.(['axis' num2str(sorted(i))]), hAxes.(['ui' num2str(sorted(i))])] = createPanelAxisTitle(gcf, pos, title);
        end
    else
        [hAxes.(['axis' num2str(sorted(1))]),hAxes.(['ui' num2str(sorted(1))])] = createPanelAxisTitle(gcf,[cframeX, cframeY, movieW, movieH], settings.display.(['d' num2str(sorted(1))]).title);
    end
    
end