# EV3 Delivery Bot
Main_Delivery contains Normal Operations as well as SmartBot Operations. <br />
SmartBot Operations- Robot is able to automatically detect which side of the line it is placed on before line tracking the line on that randomly placed side. <br />

## What can this robot do?
* Robot traps the crate with the arm when the robot is in close proximity  (using the ultrasound sensor)
* Robot line tracks with the light sensor on the right side of the line (e.g. the default)
* Robot successfully and consistently delivers the crate to the red target zone and releases the box by raising the arm
* Using a new program (e.g. Splitroad delivery), The robot delivers the crate to the intersection of the split road on the map. Once 
  delivered, the robot flashes "Delivery Successful" on the screen 1 second on, 1 second off for three times.
* In the physical twin only, robot is able to automatically detect which side of the line it is placed on before line tracking the line on that randomly placed side

## Demo

https://user-images.githubusercontent.com/73859429/163321718-663dcec8-0366-406c-969b-eafe7910aea7.mp4

## What can't this robot do?
* This robot was unable to detect the red line using getColorRGB
    * For some reason, the green value constantly maintains a high value, while the red and blue stagnates
	* Due to this, program cannot distiguish between red and black lines
	* getColorReflected works fine, but only for black or dark lines that reflect off the red line


## What was observed as differences between the virtual and physical twin?
* Arm motor values change. In this code, the arm motor is initalized by rasing it to the very top then setting that position to zero.
    * when lowering the arm, it is set to -180 for the physical robot but that is too much for the virtual (its around -150).

* Distance required to reach the end of the track is obviously different. The physical track used was shorter than the virtual 
  track, so it had to drive less of a encoder distance.

* The virtual twin has a more ideal output, that has more consistency in operation
    * Sensor values such as colours sensed and encoder values were consistent.
	* There was also uniform lighting within the virtual simulation


## Other comments to forward to developers working on this project in the future, or users of this product.
* When debugging your robot, it is sometimes a good idea to display the variables in question on the LCD.
	* There were times where the robot couldnt detect the line properly, and that was due to the difference in lighting
	  when attempting a real run.
	* Displaying the encoder values was also useful as we could measure the distance needed to travel instead of guessing and checking.
 
