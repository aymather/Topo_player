# Topo Player

The Topo Player is a Matlab application that allows users to input multiple time points of topographical data, and create a movie of electrical activity represented on a standard topographical map.

# Status
In development

# Requirements

- [MATLAB 2015b (or any more recent version)](https://www.mathworks.com/downloads/)
- [EEG Lab](https://sccn.ucsd.edu/eeglab/download.php)

# Prerequisits

- Preprocessed EEG data in standard form (columns=timepoints,rows=voltage channels)
- Chanlocs file (this is the standard chanlocs file used when using EEG Lab's topoplot function. See [EEG Lab Documentation](https://sccn.ucsd.edu/wiki/EEGLAB_Wiki) for more details.

# Usage

1. Clone/download files `git clone https://github.com/aymather/Topo_player.git`
2. Add files to Matlab Path (don't forget to add with subfolders)
3. Load in preprocessed EEG data as a variable into workspace.
4. Load in Chanlocs file as a variable into workspace.

###### Your environment is now ready. Now you need to compile your movie before you can view it. To do that, I will give an example in Matlab code:

1. Load in data:
\>> `load('exampleEEGData.mat','data');`
\>> `load('exampleChanlocsFile.mat','chanlocs');`

2. Compile using `compile_topo()` function (this step may take a few minutes depending on how much data you want to compile)
\>> `compile_topo(data, chanlocs, 'compiled-file-name');`

3. The previous step has now created two files, 'compiled-file-name.avi' & 'compiled-file-name.mat', the only difference being their extension. You will be using the .mat file for the `topo_player()` function. The .avi file is a convenience file made in case you **only** want to view your movie without extracting frames. In that case, use the following command:
\>> `implay('compiled-file-name.avi');`

4. Now you need to set up your settings for which frames to extract, and create any custom frames (like averages or montage images). Visit the [Function Documentation](./FUNCTIONDOCX.md) for information on how to set these up. Once you have done that, run the command.
\>> `topo_player('compiled-file-name.mat',0,'AddIndividualFrames',framesObj,'AddCustomFrames',customFramesObj);`

# Additional Notes

This project is still in development. I will be adding a GUI interface for most of (if not all) the steps above to make it more user friendly. I am also having a speed issue, where the fps capabilities is still lacking quite a bit. Any support or guidance on that issue is appreciated.

> Program written by: [Alec Mather](https://github.com/aymather)
