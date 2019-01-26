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

![screen shot 2019-01-26 at 5 27 44 pm](https://user-images.githubusercontent.com/41848756/51794036-e2c34a00-218f-11e9-9b72-959f2f5602a0.png)

# Additional Notes

This project is still in development. I will be adding a GUI interface for most of (if not all) the steps above to make it more user friendly. I am also having a speed issue, where the fps capabilities is still lacking quite a bit. Any support or guidance on that issue is appreciated.

> Program written by: [Alec Mather](https://github.com/aymather)
