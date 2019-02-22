# Function Documentation

This documentation will explain the functions in the Topo_player package.

# Table of Contents
- [topo_player setup]()
- [topo_player()]()
- [compile_topo()]()
- [topo_montage()]()
- [topo_average()]()

# topo_player setup
Description: This section will explain how to create settings for the `topo_player()` function which you will need to input.

##### Settings for capturing timepoints out of your movie without any manipulation.
_Note: fieldnames and data types are strict_
Example Setup:
1. Create a field that represents the times that you want to capture (in ms) assuming that column 1 of your data matrix starts at time point zero.
`framesObject.times = [40 44 60];`

2. Create a field that represents a cell array of titles for each frame captured. **There must be a title for every time point captured.**
`framesObject.titles = {'my', 'example', 'titles'};`

##### Settings for inputting custom frames.
For more information on creating custom frames see [topo_montage](#topo_montage()) or [topo_average](#topo_average())

Example Setup:

1. Create a field that represents the times (in ms) that you want to display your custom frames at assuming that column 1 of your data matrix is time point zero.
`customFramesObject.times = [100 150];`

2. Create a field that represents titles that will map onto the corresponding timepoints to display.
`customFramesObject.titles = {'Custom Title 1', 'Custom Title 2'};`

3. Create a field that represents the files created by the `topo_average()` or `topo_montage()` functions. _Note: Remember to use the files that end with a .mat extension_.
`customFramesObject.files = {'averagedData.mat', 'montagedData.mat'};`

# topo_player()
Description: This function will actually play your movie with capture frames.

Example:
`topo_player('compiled-file.mat', 0, 'AddIndividualFrames', framesObject, 'AddCustomFrames', customFramesObject);`

Inputs:

1. (required, char) 'compiled-file.mat' is the name of the .mat file that was created by your compile_topo() function.

2. (optional, int) This number represents the amount of time (ms) that the program will wait between each frame. I.e., the bigger this number, the slower your movie will play.

3. (Key, char) 'AddIndividualFrames' is the Key for the Key-Value pair that allows you extract frames out of your movie.

4. (Value, struct) framesObject is a struct with fields that represents the settings for your captured frames. See [topo_player setup]() for how to set this up.

5. (Key, char) 'AddCustomFrames' is the Key for the Key-Value pair that allows you to add custom capture frames into your movie.

6. (Value, struct) customFramesObject is a struct with fields that represents the settings for your custom frames. See [topo_player setup]() for how to set this up.

# compile_topo()
Description: This function compiles EEG data matrix into a 'example.mat' and 'example.avi' file which you can use to view your movie.

Example:
`compile_topo(data, chanlocs, 'example');`

Inputs:

1. (required, matrix) `data` is a variable that contains your preprocessed EEG data matrix where each row represents a voltage of a certain channel, and each column represents a timepoint.

2. (required, chanlocs file) `chanlocs` is a variable that holds your chanlocs file once you have loaded it in. If you are uncertain what this is, see the [wiki page](https://sccn.ucsd.edu/wiki/Channel_Location_Files) for an explanation and sample file if you do not have one already. _Note: If you have ever used the `topoplot()` function within EEG Lab, it is the same chanlocs file._

3. (required, char) 'example' is just the name of the file you will create. _Note: Do not put an extension, the program will do this for you._

# topo_montage()

Description: This function creates a custom montage frame which is basically just a lot of extracted topoplots packed into 1 frame.

**Important! Currently only supported by Matlab 2018b**

Example:
`topo_montage('example.mat', [100 150], 'montagedData');`

Inputs:

1. (required, char) 'example.mat' is the name of the file created by your `compile_topo()` function.

2. (required, double) Range of time points (in ms) that you want to montage into your frame.

3. (required, char) The name of the file to output by this function. _Note: Do not add an extension, the program will do this for you._

# topo_average()

Description: This function will create a single topoplot that represents an averaged amount of electrical activity over a specified period of time.

Example:
`topo_average(data, chanlocs, [100 150], 'averagedData');`

Inputs:

1. (required, matrix) `data` is your EEG data matrix with each row representing a channel voltage, and each column representing a timepoint.

2. (required, chanlocs) `chanlocs` is your chanlocs file.

3. (required, double) Range of time points (in ms) that you want to average together.

4. (required, char) Name of the file that you're creating. _Note: Do not add an extension, the program will do this for you._

If you do want to extract frames or add custom frames, then use the `topo_player()` function.

> Documentation written by: [Alec Mather](https://github.com/aymather)
