function compile_topo(data,chanlocs,name)

    % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
    %
    % Program Written By: Alec Mather
    %
    % Preview: This function is the first in a two part series in
    % displaying topographical data via MATLAB GUI. This function will
    % convert preprocessed EEG data into two files, one with a .avi
    % extension, and another with a .mat extension. 
    %
    % Requirements:
    %
    %   EEG Lab
    %   Link for download: https://sccn.ucsd.edu/eeglab/download.php
    %
    % Inputs:
    %
    %   REQUIRED: data (matrix)
    %               
    %           This matrix should contain your preprocessed EEG data.
    %           Each column should represent a timepoint.
    %           Each row should represent a channel value.
    %
    %   REQUIRED: chanlocs 
    %
    %           This is the same required file used to plot
    %           data in EEG Labs topoplot() function.
    %
    %   REQUIRED: name (str) 
    %           
    %           This is just a string for whatever you would like to name
    %           your files.
    %
    %           IMPORTANT NOTE: This function writes multiple files and gives 
    %                           its own extensions. DO NOT PROVIDE AN
    %                           EXTENSION
    %
    %   Example:
    %   
    %           compile_topo(data,chanlocs,'myAwesomeProject');
    %
    % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
    
    % Get current version of matlab to know how to handle anim variable
    v = ver('symbolic');
    
    % Add folder and subfolders to path
    addpath(genpath(fileparts(which('TopoStudio.m'))));
    
    % Init waitbar
    total = size(data,2);
    catstring = [' out of ' num2str(total) ' frames processed'];
    currentCount = 1;
    title = 'Compiler started...\n\n';
    
    % set handle and remove visibility
    h = figure('visible','off','Color','white');
    
    % Load in Adrian's color map
    try load('AGF_cmap.mat'); catch; warning('Could not find file AGF_cmap.mat');end
    
    % For loop that handles waitbar percentages
    fprintf(title);
    
    % set increments for iframes
    iframe = 1;

    for i = 1:total

        % separate each frame
        x = data(:,i);

        % create topoplot
        topoplot(x,chanlocs,'whitebk','on');

        % Add in Adrian's colormap
        colormap(AGF_cmap);

        % get snapshot
        frame = getframe;

        % place snapshot into animation variable
        anim(iframe) = frame;

        % increase iframe increment
        iframe = iframe + 1;

        % Clear axes to keep clean
        clf;
        
        % Update command line
        if currentCount > 1
            if length(num2str(currentCount)) == (length(num2str(currentCount - 1))) && currentCount > 1
                len = length(num2str(currentCount)) + length(catstring);
            else
                len = length(num2str(currentCount)) + length(catstring) - 1;
            end
            for j = 1:(len)
                fprintf('\b');
            end
        end
        fprintf([num2str(currentCount) catstring]);
        currentCount = currentCount + 1;
        pause(.0001);

    end

    % This warning is a known issue at mathworks and should be turned 
    % off by default
    warning off MATLAB:subscripting:noSubscriptsSpecified
    
    fprintf('\n\nSaving, please wait...');
    
    % Matlab 2018 saves this anim variable differently than
    % in 2017 so we need to convert it if we're using 2018
    if all(v.Release == '(R2018a)') || all(v.Release == '(R2018b)')

        % create video object/open for writing
        writerObj = VideoWriter([name '.avi']);
        open(writerObj);

        % write frames into .avi file
        for i = 1:total

            frame = anim(i).cdata;
            writeVideo(writerObj,frame);

        end

        % Close objects
        close(writerObj);

        % Write images into 'anim' variable for topo_player()
        videoSrc = vision.VideoFileReader([name '.avi'], 'ImageColorSpace', 'RGB');

        i = 1; % init counter
        clear anim
        while ~isDone(videoSrc)

            anim{i} = step(videoSrc);
            i = i+1;

        end

        % Remove unnecessary .avi file
        delete([name '.avi']);

    end

    % Save and compress
    save([name '.mat'],'anim','-v7.3');
            
    close(h)
    disp('Finished :)');
    disp(['The name of your movie file is ' name '.mat']);
    
end