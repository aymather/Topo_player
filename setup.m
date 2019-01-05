% Example setup using all available settings.
% Notes:
%
%       1. there must be a title for every frame presentation,
%          and the presentation times and titles must map onto
%          each other accordingly.
%       2. You cannot present 2 frames at the same time.
%       3. All custom frames can be made using the topo_montage()
%          and topo_average() functions.
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

% 'AddIndividualFrames'
standardObj.times  = [ 44    , 26  , 88 , 66   , 100    ]; % presentation times of frames in ms
standardObj.titles = {'these','are','my','test','frames'}; % titles of presented frames

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

% 'AddCustomFrames'

customObj.titles = {'Custom title 1', 'Custom title 2'}; % title of each custom frame
customObj.files  = {'average.mat'   , 'montage.mat'   }; % file containing custom frame
customObj.times  = [150             ,  20             ]; % presentation time of custom frame

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

% Example
topo_player('testFile.mat', ...
            'WaitTime',50, ...
            'AddIndividualFrames',standardObj, ...
            'AddCustomFrames',customObj);
        
        
        
        
        
        