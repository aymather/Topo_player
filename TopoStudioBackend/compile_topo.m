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
    
    % Add folder and subfolders to path
    addpath(genpath(fileparts(which('TopoStudio.m'))));
    
    % Load in Adrian's color map
    try load('AGF_cmap.mat'); catch; warning('Could not find file AGF_cmap.mat');end
        
    % set increments for iframes
    iframe = 1;
    
    % set handle and remove visibility
    h = figure('visible','off','Color','white');
    
    for i = 1:size(data,2)
        
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
        
        % clear figure (must do this to prevent figure from slowing down)
        clf

    end
    
    % create video object/open for writing
    disp('Writing Files...');
    writerObj = VideoWriter([name '.avi']);
    open(writerObj);
    
    % write frames into .avi file
    for i = 1:length(anim)
        frame = anim(i).cdata;
        writeVideo(writerObj,frame);
    end
    close(writerObj);
    
    % This warning is a known issue at mathworks and should be turned 
    % off by default
    warning off MATLAB:subscripting:noSubscriptsSpecified
    
    % Write images into 'anim' variable for topo_player()
    videoSrc = vision.VideoFileReader([name '.avi'], 'ImageColorSpace', 'RGB');
    
    clear anim % clear the anim variable to write into corrrect format
    i = 1; % init counter
    while ~isDone(videoSrc)

        anim{i} = step(videoSrc);
        i = i+1;

    end
    
    disp('Saving...');
    save([name '.mat'],'anim','-v7.3');
    
    % close all figures
    close all
    disp('Finished :)');
    disp('You should now have two files');
    disp(['File 1: ' name '.avi is used for the implay() function']);
    disp(['File 2: ' name '.mat is used for the topo_player() function']);
    
end