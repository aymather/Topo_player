function topo_player(filename,varargin)

    % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
    %
    % By: Alec Mather - University of Iowa - Wessel Lab - Dec. 2018
    %
    % Preview: This function is the second part in a two step process. See
    % the compile_topo() function for part one. This function will display
    % a movie of topographical data in a MATLAB GUI with a 'pause' button,
    % a reset button and an 'exit' button. In order for this function to work,
    % your file must be in .mat format.
    %
    % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
    % 
    % Function Requirements: MATLAB 2018b/EEG Lab
    %
    % Links for Download:
    %   
    %   MATLAB 2018b: https://www.mathworks.com/downloads/
    %   EEG Lab: https://sccn.ucsd.edu/eeglab/download.php
    %   
    % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
    %
    % Inputs:
    %
    %   REQUIRED: filename (str) == file which has been compiled by the
    %        compile_topo() function. This should end with a .mat extension.
    %        Example: filename = 'exampleVideo.mat';
    %
    %   All other inputs are optional Key Value pairs.
    %
    %   Key: 'WaitTime'
    %   Value: double
    %        This is the number of ms between each frame as you play the
    %        movie. In other words, the higher this number, the slower your
    %        movie will play.
    %
    %   Key: 'AddIndividualFrames'
    %   Value: struct with fields .times
    %                             .titles
    %        
    %        The times is an array of times in ms that you would like to
    %        extract from the movie.
    %        The titles is a cell array of titles that will map onto those
    %        extracted times.
    %
    %        Example: x.times  = [ 44 , 66   , 88     ];
    %                 x.titles = {'my','test','titles'};
    %       
    %        Notes: 1. There must be a title for every time.
    %               2. Titles must map onto their respective time.
    %
    %   Key: 'AddCustomFrames'
    %   Value: struct with fields .times
    %                             .titles
    %                             .files
    %
    %       Times and titles struct is the same as 'AddIndividualFrames'.
    %       files is a cell array of .mat file names that point to custom
    %       made images using the topo_average() and topo_montage()
    %       functions.
    %
    %       Example: x.times  = [ 150,200,300 ];
    %                x.titles = {'Averaged bw 100:150ms',...
    %                            'Montage bw 180:200ms',...
    %                            'Averaged bw 280:300ms'};
    %                x.files  = {'customAveragedFrame.mat',...
    %                            'montage180-200.mat',...
    %                            'averaged280-300.mat};
    %
    % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
    
    % Add folder and subfolders to path
    addpath(genpath(fileparts(which('TopoStudio.m'))));

    % Initialize the video reader.
    disp('Loading in Video File...');
    try load(filename,'anim'); catch; disp(['Your ' filename ' file does not contain the anim variable, you may be loading the wrong file']); end
    
    % Defaults
    defaultWaitTime = 0;
    defaultExport = 0;
    defaultSettings = [];
    
    % Function checks
    validSingleObj = @(x) isstruct(x) && ... % object is a struct with fields
                          isfield(x,'times') && ... % has a frame field
                          isfield(x,'titles') && ... % has a title field
                          isa(x.times,'double') && ... % capture times field is a double
                          isnumeric(x.times); % times are numeric values
                      
    validCustomFrame = @(x) isstruct(x) && ... % object is a struct with fields
                            isfield(x,'times') && ... % has a presentation time field
                            isnumeric(x.times) && ... % presentation time is a number
                            isfield(x,'titles') && ... % custom frame has a title
                            iscell(x.titles) && ... % title is a character string
                            isfield(x,'files') && ... % has a field to point to files
                            iscell(x.files); % files is a cell array
                      
    % Create custom scheme for Key Value pair inputs
    p = inputParser;
    addRequired(p,'FileName');
    addParameter(p,'Settings',defaultSettings);
    addParameter(p,'WaitTime',defaultWaitTime);
    addParameter(p,'Export',defaultExport);
    addParameter(p,'AddIndividualFrames',[],validSingleObj);
    addParameter(p,'AddCustomFrames',[],validCustomFrame);
    
    % Parse inputs and validate
    parse(p,filename,varargin{:});
    
    % Initialize settings
    settings = topo_init(p,anim);
    
    % Init frame counter
    global framenum; framenum = 1;

    % Axes/Buttons
    % Create a figure window and axes to display
    [hFig, hAxes] = createFigureAndAxes(settings);
    
    % Remove buttons if we are exporting to .avi file
    if ~settings.export
        % Add buttons to control video playback.
        insertButtons(hFig, hAxes, settings);
    end
    
    % Display input video frame on axis
    showFrameOnAxis(hAxes.axisMain, settings.anim(framenum).cdata);
    
    % If we're exporting, just start the movie and export result
    if settings.export
        
        % Close everything to prevent confusion with getframes
        close(TopoStudio);
        
        % Start movie
        exportObj = playCallback(hFig,[],hAxes,settings);
    
        % Remove extension from filename
        file = filename(1:(end - 4));
        
        fprintf('\nWriting frames to .avi file...please wait...|');
        
        % create video object/open for writing
        writerObj = VideoWriter([file '.avi']);
        open(writerObj);
        
        % Spinner Array
        spinner = [{'|'},{'/'},{'-'},{'\\'},{'|'},{'/'},{'-'},{'\\'}]; count = 1;
        
        % write frames into .avi file
        for ib = 1:length(exportObj)
            
            fprintf(['\b' spinner{count}]);
            count = count + 1; if count > length(spinner); count = 1; end
            frame = exportObj(ib).cdata;
            writeVideo(writerObj,frame);

        end
        
        fprintf('\nFinished!\n');
        close(writerObj);
        
    end
    
end
