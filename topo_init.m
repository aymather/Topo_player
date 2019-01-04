function settings = topo_init(p,anim)
    
    % Make a settings variable for things you need to pass so
    % as to reduce confusion and make things cleaner
    
    % Sample Rate
    settings.srate = 500; % Hz
    
    % Durations
    settings.durations.waitTime = p.Results.WaitTime; % ms
    
    % Animation Video
    settings.anim = anim;
    
    % Deconstruct Objects from inputParser
    
    % Individual Frames
    if ~isempty(p.Results.AddIndividualFrames)
        
        % Convert ms input to frame numbers
        cframes = [];
        for i = p.Results.AddIndividualFrames.times(1:end)
            if ~mod(i,2)
                cframes = [cframes, time2frame(settings,i)];
            end
        end
        
        % Make sure there are equal frames and titles
        assert(length(cframes) == length(p.Results.AddIndividualFrames.titles),['You have ' num2str(length(cframes))...
                                                                                ' frames you are trying to capture, and' ...
                                                                                num2str(length(p.Results.AddIndividualFrames.titles))...
                                                                                ' titles, you must have a title for every frame.']);
        settings.cframes.individualDisplayFrames = cframes;
        settings.titles.individualFramesTitles = p.Results.AddIndividualFrames.titles;
        
    end
    
    % Averaged Frame
    if ~isempty(p.Results.AddAveragedFrame)
        
        % Set titles and display times from input parser
        
        % If presentation time is an odd number, round up
        if mod(p.Results.AddAveragedFrame.presentationTime,2)
            p.Results.AddAveragedFrame.presentationTime = p.Results.AddAveragedFrame.presentationTime + 1;
        end
        settings.cframes.averagedDisplayFrame = time2frame(settings,p.Results.AddAveragedFrame.presentationTime);
        settings.titles.averagedFrameTitle = p.Results.AddAveragedFrame.title{1};
        
        if ~isfield(p.Results.AddAveragedFrame, 'matFile')
            
            disp('Creating custom averaged frame...');

            % Create customized averaged frame
            plotdata = mean(p.Results.AddAveragedFrame.data,2); % average the data
            chanlocs = p.Results.AddAveragedFrame.chanlocs; % chanlocs file
            try load('AGF_cmap.mat'); catch; warning('Could not find file AGF_cmap.mat');end % load Adrian's colormap
            figure('visible','off','Color','white'); % create figure but hide it
            topoplot(plotdata,chanlocs,'whitebk','on'); % plot data
            colormap(AGF_cmap); % change color map
            framedata = getframe; % get frame data

            % Now we need to compile the frame data with a color map
            writerObj = VideoWriter(p.Results.AddAveragedFrame.title{1}); % VideoWriter object instance
            open(writerObj); % open VideoWriter instance object
            frame = framedata.cdata; % extract frame
            writeVideo(writerObj,frame); % write frame
            close(writerObj); % close writer object

            % Known matlab bug, turn off unnecessary warning
            warning off MATLAB:subscripting:noSubscriptsSpecified

            % Now read the file we just created and save it to settings struct
            videoSrc = vision.VideoFileReader([p.Results.AddAveragedFrame.title{1} '.avi'], 'ImageColorSpace', 'RGB');
            averagedFrame = step(videoSrc);

            % Save compressed variable to a .mat file
            save([p.Results.AddAveragedFrame.title{1} '.mat'], 'averagedFrame','-v7.3');
            
            settings.displayFrames.averaged = averagedFrame;
            
        else
            
            load(p.Results.AddAveragedFrame.matFile, 'averagedFrame');
            settings.displayFrames.averaged = averagedFrame;
            
        end
        
    end
    
    % Montage Frame
    if ~isempty(p.Results.AddMontageFrame)
        
        % If input is an odd number, round up
        if mod(p.Results.AddMontageFrame.presentationTime,2)
            p.Results.AddMontageFrame.presentationTime = p.Results.AddMontageFrame.presentationTime + 1; 
        end
        settings.cframes.montageDisplayFrame = time2frame(settings,p.Results.AddMontageFrame.presentationTime); % convert time to frame number
        settings.titles.montageFrameTitle = p.Results.AddMontageFrame.title{1}; % title
        
        if isfield(p.Results.AddMontageFrame, 'timeWindow')
            
            disp('Creating custom montage...');
            
            % Create custom montage
            figure('visible','off','Color','white'); % open invisible figure
            montage(settings.anim(p.Results.AddMontageFrame.timeWindow(1):p.Results.AddMontageFrame.timeWindow(2))); % montage
            framedata = getframe; % get frame data
            
            % Now we need to compile the frame data with a color map
            writerObj = VideoWriter(p.Results.AddMontageFrame.title{1}); % VideoWriter object instance
            open(writerObj); % open VideoWriter instance object
            frame = framedata.cdata; % extract frame
            writeVideo(writerObj,frame); % write frame
            close(writerObj); % close writer object

            % Known matlab bug, turn off unnecessary warning
            warning off MATLAB:subscripting:noSubscriptsSpecified

            % Now read the file we just created and save it to settings struct
            videoSrc = vision.VideoFileReader([p.Results.AddMontageFrame.title{1} '.avi'], 'ImageColorSpace', 'RGB');
            montageFrame = step(videoSrc);

            % Save compressed variable to a .mat file
            save([p.Results.AddMontageFrame.title{1} '.mat'], 'montageFrame','-v7.3');
            
            settings.displayFrames.montage = montageFrame;
            
        elseif isfield(p.Results.AddMontageFrame, 'matFile')
            
            load(p.Results.AddMontageFrame.matFile, 'montageFrame'); % load .mat file
            settings.displayFrames.montage = montageFrame;
            
        end
        
    end
    
    settings.allTitles = {};
    if isfield(settings,'titles')
        if isfield(settings.titles,'individualFramesTitles'); settings.allTitles = {settings.allTitles{:}; settings.titles.individualFramesTitles{:}};end
        if isfield(settings.titles,'averagedFrameTitle'); settings.allTitles{(length(settings.allTitles)+1)} = settings.titles.averagedFrameTitle;end
        if isfield(settings.titles,'montageFrameTitle'); settings.allTitles{(length(settings.allTitles)+1)} = settings.titles.montageFrameTitle;end
    end
    
    settings.allCFrames = [];
    if isfield(settings,'cframes')
        if isfield(settings.cframes,'individualDisplayFrames'); settings.allCFrames = [settings.allCFrames, settings.cframes.individualDisplayFrames];end
        if isfield(settings.cframes,'averagedDisplayFrame'); settings.allCFrames = [settings.allCFrames, settings.cframes.averagedDisplayFrame];end
        if isfield(settings.cframes,'montageDisplayFrame'); settings.allCFrames = [settings.allCFrames, settings.cframes.montageDisplayFrame];end
    end
    
    % Screen Dimensions
    settings.screen.owd = get(0,'ScreenSize');
    
    % Frame flags
    global IDF; global ADF; global MDF;
    IDF = true; ADF = true; MDF = true;
    
end