function topo_montage(filename,settings,timeWindow,title)

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
    
    % Add folder and subfolders to path
    addpath(genpath(fileparts(which('TopoStudio.m'))));
    
    disp('Loading movie file...');
    try load(filename,'anim'); catch; warning('Something went wrong trying to load your .mat file'); return; end
    
    figure('Color','white','Visible','off'); % open figure
    window = time2frame(settings,timeWindow(1)):time2frame(settings,timeWindow(2));
    for it = 1:length(window)
        
        montageObj{it} = anim(window(it)).cdata;
        
    end
    
    imdisp(montageObj); % plot
    h = gcf; % get handle
    h.Color = [1 1 1]; % change background to white
    
    if nargin > 3
        
        disp('Creating custom frame...');
        
        frameData = getframe(h); % get frame data
        frameData = frameData.cdata;

        % Save compressed variable to a .mat file
        save([title '.mat'], 'frameData','-v7.3');

    end

end