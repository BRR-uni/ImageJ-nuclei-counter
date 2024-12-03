# ImageJ-nuclei-counter
### This plugins helps in to automate the image processing necesary to segment and count nuceli from presumably alive cells from DAPI staining confocal microscopy images
These are two FIJI (ImageJ) plugins I used to automate part of the image processing I needed to count nuclei from confocal microscopy images. It has the potential to greatly improve the time to do repetitive image processing.

How to install
To run the software provided, you will need to install the FIJI (ImageJ) software first. Once ready, you ill have to download the .ijm files and place them in the right directory. Depending on your system or instalation, the path should look like this C:\Program Files (x86)\Fiji.app\scripts\Plugins Once you have the files there, open the FIJI program an use the search bar or ctrl + L to search for the names of the plugins you just downloaded.
Additionally you will need to install the StarDist plugin which is documented [elsewhere](https://github.com/stardist/stardist).
The repository contains two sample images in which you can run both plugins for test porpouses.

## Alive_Nuclei_Count_Semi-Auto
This plugin is to partially automate the process of segmenting and counting nuclei from confocal microscopy images (CZI format). I called this plugin semi-Auto because it will stop the script to allow the user to manually set the thresholding values for the image. This allows some tunability but keep in mind that images form the same batch of experiments should mantain threshold values. The rest of the process will be the same as the fully automated plugin, and will be detailed in its section
To use it properly:
- Run the plugin and a file search window should pop up
- Select the CZI image you want to open
- Make sure you mark the "Split channels" option in the Import Options window
![image](https://github.com/user-attachments/assets/3c985e92-8213-4c4d-b454-7fc481665b0d)
- Manually change the threshold to a value that lets nuclei distinguishable
![image](https://github.com/user-attachments/assets/30c69f07-607d-4f13-a9ee-ab347755d3ee)
- Click apply and then Ok in the Action Required prompt
- Finally, the result window and the image with a color mask overlay identifying the nuclei counted should look similar to this, depending of course on the image and the threshold values used:
![image](https://github.com/user-attachments/assets/a6d83b54-d454-4d11-b138-84b8adee6532)


## Automatic_Alive_Nuclei_Count
This is a fully automated version of the previous plugin, so there is no chance to adjust the threshold. If you find a consistant threshold value for your images, you can modify the code and use those values insted. Once done that, the code should save a lot of time when doing the same processing over and over. It is important that this plugin requieres you to already have opened the image you want to work with, meaning it does not open a file search window when you run it.
The plugin basically does the following:
- Sets the Scale
- Runs a Gaussian Blur operation
- Runs StarDist plugin with certain prespecified values
- Runs a threshold
- Converts to a mask
- Runs a watershed binary operation
- Runs Analyze Particles on certain prespecified values
- Adds a Scale bar
- Returns a summary of the objects counted

To run the plugin properly:

- Open the image you want to process
- Mark the split channels box form the import options window
![image](https://github.com/user-attachments/assets/3c985e92-8213-4c4d-b454-7fc481665b0d)
- You can close the channels you wont use and select (just click) the image you will use
- Run the plugin
- The process should complete and show a similar result depending of course on the image you use
![image](https://github.com/user-attachments/assets/869f9458-6433-4914-8ddb-04e587755673)




## Find a bug?
If you found an issue or would like to submit an improvement to this project, please submit an issue using the issues tab above. If you would like to submit a Pull Request with a fix, reference the issue you created.

## Known issues (Work in progress)
- Both plugins are far from perfect and could improve in two ways to make sure you are counting nuclei form alive cells:
  - Taking into acount more features might help in achieving a more consistant thresholding
  - More input data could improve consistant segmentation

The pluggins are deffinitely overfitted to my applications, therefore they lack some generalization features:
- The scale set was usefull for my experiments, but will probably change for each microscope used, so you have to manually and carefully set the scale depending on your case. Again this can only be accessed from the code itself
- The semi-Auto plugin depends on the Splitt channel option which by default will name each channel from the image. If your Dapi Staining is named different from C=2, you need to change it manually from the code. In general the ImageJ macro language will make difficult to handle working with multiple windows, but it is deffinitely something fixable to work smoothly.
- The features on StarDist are mostly arbitrarily chosen, so they criteria to select proper values might be improved
