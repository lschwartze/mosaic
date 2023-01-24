Collage is a matlab programm that combines given pictures to a collage that was specified by the user
requirements: Matlab 2020a or newer and Java

1. directory checkBrightness
The collage program first has to decide wether a given picture is light or dark. 
To achieve this I created a perceptron that reads information from the matlab function checkBrightness. For given 
pictures this function loops through every individual pixel and views the RGB value. Then, the average of each 
component is calculated. I saved 20 pictures from Google that were either distinctely dark or light and gave them
to checkBrightness. The results were then saved in a matlab matrix document.

2. directory perceptron
Now I had two sets of dark and light pictures with their respective average RGB value. Since light/dark are linear
seperable attributes I could use this (admittably very small) dataset to train the perceptron in perceptron.m. 
The trainer returned a vector that can be used to categorize pictures as light or dark. 

3. directory paint
In this directory I saved a Java file, that allow the user to manually paint the collage they want to draw. 
Running the script opens window where the dimensions can be entered. Each pixel will later be represented as one
picture in the collage. After entering the dimensions, a table of buttons made with awt.swing is opened. 
A pressed button will draw a dark pixel and an unpressed button a light pixel. By pressing the green button, the
created mosaic will be stored in the file mosaic.png

4. startCollage
By running this script, the process of creating a collage has begun. Congrats. First the user will be asked to
enter the name of the directory where their pictures are saved. This directory has to be located within the 
collage directory. Then, the user can decide wether they want the programm to artificially increase the contrast
between light and dark pictures. See adjustContrast for more details. 
Next, the all of the pictures have to be the same size in order to concatenate them. See checkSize for more details
A user might want to run the program multiple times to create multiple collages, therefore a database is created
and stored within the directory the user created for their pictures, 
that saves all of the pictures and their brightness. I added this bit because calculating the actual brightness
with the perceptron was the most time-consuming job and this process can be sped up. Before calling the function
to calculate the brightness of a picture, the database is searched.
If a picture has not been seen before, the brightness has to be calculated, see separateBrightness for more info.
There are now two arrays, one stores all the light pictures, the other all the dark ones. If a user wanted to 
adjust the contrast even more, the "Dark" array will be used, see adjustContrast for more details.
Both arrays will be forwarded to createCollage.m.

5. createCollage
This function basically starts the process within matlab to calculate the collage. First the mosaic created in
Java has to be read. See readMosaic.m for more info. 
A 2-dimensional char array has now been created. Each char is either "W" or "B" representing a white or black
pixel. Each row of the array will be forwarded to row.m.

6. Row
For each char in this row, a random picture will be chosen
from the "Dark" or "Light" array respectively and then concatenated to all the previous pictures.
Lastly, all rows have to be conatenated and the picture is created.

7. checkSize
This code corrects different sizes throughout all pictures in order to make them combinable. It also recognizes
wether a picture has been taken horizontally and rotates for the correct the format. The new size will
be given by the average of all sizes. After resizing, each picture overwrites its original, so saving a backup 
is advised in case something fails.

8. separateBrightness
If a picture isn't already stored in the database, it has to have its brightness calculated. From the perceptron
file, a threshold vector is known. Now the average RGB value will be computed and plugged into the perceptron.
An array with dark pictures and one with light pictures are returned.

9. adjustContrast
If asked for by the user, the code can artificially stagger the contrast between dark and light pictures. An 
additional directory is created where the new pictures are saved. This has to be done in order to prevent the
original .png files from being overwritten. Then, each pixel will be manually darkend if possible. Currently, 20 
is substracted from each component of each RBG value, seems to work fine but can also be more or less.
New pictures will be saved, dark array has to be redone.

10. readMosaic
After creating the mosaic in Java it is saved in the Paint directory. Each pixel is read here and a 2-dimensional
array is created. Every pixel ressembles one component of the array, W means white, B means black pixel.
