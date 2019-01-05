function topo_montage(filename,timeWindow,title)

    % % % % % % % % % % % % % % % % % % % % % % % % % % 
    %
    % This function creates a montage image of a specified
    % time range of a topoplot movie.
    %
    % Inputs:
    %
    %       filename(char,required)
    %       this is the file that the compile_topo() function
    %       creates. It should end with a .mat extension.
    %
    %       timeWindow(double,required)
    %       time range to capture
    %       Example: timeWindow = [50 80];
    %
    %       title(char,optional)
    %       giving a title will tell the program to save a .mat
    %       and .avi file of the image you just created
    %
    % % % % % % % % % % % % % % % % % % % % % % % % % % 

    settings.srate = 500; % Hz

    try load(filename,'anim'); catch; warning('Something went wrong trying to load your .mat file'); return; end
    
    figure('Color','white'); % open figure
    montage(anim(time2frame(settings,timeWindow(1)):time2frame(settings,timeWindow(end))));
    
    if nargin > 2
        
        disp('Creating custom frame...');
        
        data = getframe; % get frame data
            
        % Now we need to compile the frame data with a color map
        writerObj = VideoWriter(title); % VideoWriter object instance
        open(writerObj); % open VideoWriter instance object
        frame = data.cdata; % extract frame
        writeVideo(writerObj,frame); % write frame
        close(writerObj); % close writer object

        % Known matlab bug, turn off unnecessary warning
        warning off MATLAB:subscripting:noSubscriptsSpecified

        % Now read the file we just created and save it to settings struct
        videoSrc = vision.VideoFileReader([title '.avi'], 'ImageColorSpace', 'RGB');
        frameData = step(videoSrc);

        % Save compressed variable to a .mat file
        save([title '.mat'], 'frameData','-v7.3');

    end

end