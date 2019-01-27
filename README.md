# Topo Player

The Topo Player is a Matlab application that allows users to input multiple time points of topographical data, and create a movie of electrical activity represented on a standard topographical map.

# Status
Montage frames are currently not supported with Matlab versions before 2018.

# Requirements

- [MATLAB 2015b (or any more recent version)](https://www.mathworks.com/downloads/)
- [EEG Lab](https://sccn.ucsd.edu/eeglab/download.php)

# Prerequisits

- Preprocessed EEG data in standard form (columns=timepoints,rows=voltage channels)
- Chanlocs file (this is the standard chanlocs file used when using EEG Lab's topoplot function. See [EEG Lab Documentation](https://sccn.ucsd.edu/wiki/EEGLAB_Wiki) for more details.

# Usage

1. Clone/download files `git clone https://github.com/aymather/Topo_player.git`

2. Add files to Matlab Path (don't forget to add with subfolders)

3. At the command line type `TopoStudio` which will bring up the following GUI:
![screen shot 2019-01-26 at 5 27 44 pm](https://user-images.githubusercontent.com/41848756/51794036-e2c34a00-218f-11e9-9b72-959f2f5602a0.png)

4. The top section named "Compiler" is where you will select files to compile your movie.
Data is your preprocessed EEG data matrix (columns = timepoints, rows = channel voltage). Chanlocs File is your standard chanlocs file. And at the end you can type in a file name and hit ENTER to name your file. _Note: do not give your file name an extension, the program will do this for you!_
![screen shot 2019-01-26 at 5 27 57 pm](https://user-images.githubusercontent.com/41848756/51794051-4fd6df80-2190-11e9-9b4b-0fa0d3f06482.png)

5. Once you have compiled your movie, you may now play it. At the bottom you can see the "Stage." This is where you will prepare your movie. 
![screen shot 2019-01-26 at 5 28 33 pm](https://user-images.githubusercontent.com/41848756/51794116-9416af80-2191-11e9-9167-3069fb59e227.png)
Since all we have at this point is a compiled movie, let's just load that in and play it. Click on "Select Movie File" and find the .mat file you just created. When you hit enter you should see that that file is chosen under the button you just pressed. Now hit "Play Movie."

6. Now that you've seen your movie in action, you can now pick out individual frames to present along side your movie. Just above the stage there are two sections called "Stage Individual Frames" and "Stage Custom Frames."
![screen shot 2019-01-26 at 5 28 23 pm](https://user-images.githubusercontent.com/41848756/51794178-cc6abd80-2192-11e9-830c-900a91b0faa8.png)
- Go to "Stage Individual Frames" and type in a time (in milliseconds) that you would like to see displayed along side your movie. _Important: This application assumes a sample rate of 500 Hz which means that for each column of data, two milliseconds have passed. Therefore, giving an odd number as an input will give you an error. Also, the very first column of your data (frame 1) is considered timepoint 0_
- Then give your frame a title.
- Once you have those two fields filled out, click "Add to Stage". You should see now at the Staging area that the title of your frame has been added! The Staging area will keep track of all the settings currently staged. Now you can add a couple more individual frames, or you can click "Play Movie."

7. If you want to stage a Custom frame, you must first create it. Go just above to the sections titled "Create Custom Montage" and "Create Custom Average."
![screen shot 2019-01-26 at 5 28 10 pm](https://user-images.githubusercontent.com/41848756/51794201-0936b480-2193-11e9-8260-bc06cd185c63.png)
###### Custom Montage
- A custom montage will look like an array of topoplots all placed into a single frame.
- Select your movie file that you created from step 4.
- Give your range of time points from start to finish.
- Finally, name the new custom frame (don't give it an extension).
- _Important: Montage frames are currently not supported in Matlab versions earlier than 2018_

###### Custom Average
- A custom averaged frame takes averages from your EEG data, so you need those raw files.
- Select your preprocessed EEG data.
- Select your chanlocs file.
- Give a time range to average together.
- Name your file, without an extension.

8. Now that you've created your custom frames, go back to "Stage Custom Frame" and it is the same process as staging an individual frame, except you must select the file that you just created in step 7.

9. In your Staging area, there is also a field called Wait Time. This is the amount of time that the program will "Wait" in between frames, slowing your movie down (i.e., the bigger this number, the slower your movie will run). Default speed is 0 which is as fast as possible. Type in a number and hit ENTER to commit it to the stage.

10. If you don't like what's on your stage, no worries! There's a "Reset Stage" button right next to the "Play Movie" button. It will clear your entire stage.

# Pull Request Suggestions

- Speed issue: Currently the movie cannot play very fast. Looking for a more effecient way to display frames in topo_player()
- Support for Create Montage Frame: Find a way to support montage frames for Matlab versions earlier than 2018.

> Program written by: [Alec Mather](https://github.com/aymather)
