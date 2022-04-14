# EV3 Barcode Reader Bot

## What can this robot do?
* This robot can read the barcode by slowly moving forward and writing the light sensor value to the datalog of the controller.
  Then a csv file can be saved onto the computer, and MATLAB code can decode the barcode using the
  relative widths of the black bar to the white space.

* Sensor can also read coloured barcodes as long as the colors are not too similar.

  ~Physical Robot
  - Can distinguish between noissy black and white lines (and coloured lines) of the barcode
  - Reads the bar code and display the Output on the LCD Display
  - Can read a paper sized barcode at varying speeds (5 percent speed is primarily used)
  - Stops after the last bar read

  Physical Robot Barcode Reader:

  https://user-images.githubusercontent.com/73859429/163313001-b605089e-6944-4c18-a28f-90dbf56e3b2f.mp4  
  
  
  ~Virtual Robot
  - Can distinguish between noissy black and white lines of the barcode
  - The virtual robot has a more ideal output for the color values as it's in an ideal environment
  - Returns consistent color sensor values
  - Stops after the last bar is read
  
  Virtual Robot Barcode Reader:

  https://user-images.githubusercontent.com/73859429/163313174-a2e34825-d7c3-4b75-bcb3-a7cacc10960a.mp4


* There is also a real-time robotC code that can directly read the barcode value as it runs, and displays it onto
  the LCD (No MATLAB required).
  
  https://user-images.githubusercontent.com/73859429/163313434-fb8578a0-bc70-4f5b-8849-1df1c6285a07.mp4

<p align="center">
  <img src="https://user-images.githubusercontent.com/73859429/163313434-fb8578a0-bc70-4f5b-8849-1df1c6285a07.mp4" alt="animated" />
</p>

## What can't the robot do?
  
  ~Physical Robot
  - The robot can't read really small barcodes, although there was no tape applied to the colour sensor for reading thin lines. 
    (would have probably worked with tape applied to minimilize light illuminated by sensor)

  ~Virtual Robot
  - The robot glitches out sometimes leading it to not count certain values or count when it shouldn't, resulting in the 
    robot stop mid barcode read.
    (This error may be due to robotC remote access or small glitches within code causing loop to run more than once per iteration)

## What was observed as differences between the virtual and physical twin?
 
  * The values for the color reflected are different for the virtual and physical robot (ideal vs real environment)
  * The getcolorreflected values for the virtual robot were more defined 
  * Distance traveled by the virtual robot is significantly larger increasing the time it takes for the robot to finish

## Other comments to forward to developers working on this project in the future, or users of this product.
  
  * When uploading barcode to Virtual World, set Width = 1, Height = 0.5.
  * If you want to read actual barcodes, you require a higher resolution color sensor.
  * The ratio of black to white cannot be close to a 1:1 ratio. It should at least be a 2:1 or a 1:2.
  * The thresholds values need to be adjusted for both robotC and MATLAB codes depending on 
    physical or virtual bot.
  * When reading the values of the reflected color, add a sleep to delay the rate at which the values are read and saved
    so that the the saved values do not exceed the datalog capacity.
  * Try to initialize the color sensor for the physical robot before running your program to prevent any sensor misreading.
  * Make use of gears for more accurate rotation of wheels if needed to control precision of robot.


## MATLAB barcode decoder:
    1. Reads from csv file using the csvread function
    2. Converts the continous light sensor readings into binary 0s and 1s using a adjustable threshold value
       (black is 0, white is 1)
    3. Measures the length of the first black bar by counting the number of 0s until it hits a 1.
       Then measures the length of the white space, and alternates until it read 4 black bars and 4 white spaces.
    4. Calculates the ratio of black to white by dividing the black by black + white. Repeats 4 times.
    5. If the ratio is < 0.5, the digit is 1, otherwise it is 0.
    6. Converts binary to decimal, and display the answer.
   
## MATLAB barcode decoder notes:
  * The barcode decoder works by comparing the relative widths of each segment, therefore it should work
    if the barcode is all 0s or all 1s.
  * This code expects the reader to start datalogging from a black bar. Otherwise it will fail.
  * Currently hardcoded to read only 4 segments, although this could easily be increased.
  * The relative widths of each segment should not be close to 0.5 or a 1:1 ratio.


## MATLAB barcode generator:
    1. Prompts the user to enter a value between 0 and 15 (including)
    2. Converts the input to binary, then flips it
    3. Splits the 1080 x 1920 image into 4 segments, each 480 pixels wide. This will be the edge of each
       segment. For each edge, if the next input is 1, it makes the next 360 pixel columns black (thick bar).
       Otherwise, it makes the next 120 pixels black (thin bar).
    4. Adds noise to the image by adding a random value to each pixel (it also slightly compresses the image
       and shifts it up a little bit so that noise can go above and below for both black and white areas).
    5. Creates the png image using the imwrite function

### Aditional Notes:
  - If the user inputs a non-integer value, it will just ignore the decimal place (round down).
  - The size of the png image and the amount of noise can be easily adjusted 
