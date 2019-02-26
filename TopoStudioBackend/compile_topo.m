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
    
    % Close all figures and axes so that frame size cannot get messed up
    close all;
    close(TopoStudio);
    
    % Add folder and subfolders to path
    addpath(genpath(fileparts(which('TopoStudio.m'))));
    
    % Init waitbar
    total = size(data,2);
    catstring = [' out of ' num2str(total) ' frames processed'];
    currentCount = 1;
    title = 'Compiler started...\n\n';
    
    % Spinner Array
    spinner = [{'|'},{'/'},{'-'},{'\\'},{'|'},{'/'},{'-'},{'\\'}]; count = 1;
    
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
                len = (length(num2str(currentCount)) + length(catstring) + 2);
            else
                len = (length(num2str(currentCount)) + length(catstring) - 1) + 2;
            end
            for j = 1:(len)
                fprintf('\b');
            end
        end
        
        fprintf([num2str(currentCount) catstring ' ' spinner{count}]);
        count = count + 1;
        if count > length(spinner); count = 1; end
        currentCount = currentCount + 1;
        pause(.0001);

    end

    % This warning is a known issue at mathworks and should be turned 
    % off by default
    warning off MATLAB:subscripting:noSubscriptsSpecified
    
    fprintf('\n\nSaving, please wait...');

    % Save and compress
    save([name '.mat'],'anim','-v7.3');
            
    close(h)
    disp('Finished :)');
    disp(['The name of your movie file is ' name '.mat']);
    TopoStudio;
    
end