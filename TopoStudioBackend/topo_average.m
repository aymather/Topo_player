function topo_average(data,chanlocs,timeWindow,title)

    % % % % % % % % % % % % % % % % % % % % % % % % % % 
    %
    % This function creates an averaged topoplot image
    % within a specified time range.
    %
    % Inputs:
    %
    %       data(matrix, required)
    %       Full data matrix of eeg data where each column
    %       is a sample, and each row is a channel voltage.
    %
    %       chanlocs(required)
    %       standard chanlocs file for topoplot
    %
    %       timeWindow(double,required)
    %       time window in ms that you would like to average.
    %       Keep in mind that column 1 of your data matrix 
    %       is considered 0ms.
    %       Example: timeWindow = [50 100];
    %
    %       title(char,optional)
    %       giving a title will tell the program to save both 
    %       a .mat and .avi version of what you just created.
    %
    % % % % % % % % % % % % % % % % % % % % % % % % % % 
    
    % Add folder and subfolders to path
    addpath(genpath(fileparts(which('TopoStudio.m'))));
 
    settings.srate = 500; % Hz

    plotdata = data(:,time2frame(settings,timeWindow(1)):time2frame(settings,timeWindow(end)));
    averagedData = mean(plotdata,2);
    try load('AGF_cmap.mat'); catch; warning('Could not find file AGF_cmap.mat');end % load Adrian's colormap
    figure('Color','white','Visible','off'); % create figure but hide it
    topoplot(averagedData,chanlocs,'whitebk','on'); % plot data
    colormap(AGF_cmap); % change color map

    if nargin > 3
        
        disp('Creating your custom frame...');
        
        data = getframe; % get frame data

        % extract what we need
        frameData = data.cdata; % extract frame

        % Save compressed variable to a .mat file
        save([title '.mat'], 'frameData','-v7.3');
        
        fprintf('Finished!\n');
        
    end

end