# EV3 Line Maze Solver Bot

## What can this robot do?
* This robot can determine the shortest path from any starting to ending point in a maze
   
* Has the entire maze hard-coded within a struct
  
* Determines the shortest path in memory first
    * Uses right line follower algorithm to find a path to end point, 
  	  then cuts any dead ends and nullifiable values to determine the shortest and best path

* Uses colour sensor to perform line tracking
    * Temporarily ignores colour sensor and drives straight when crossing/turning at an intersection
   	* Different colour sensor thresholds for black or yellow lines (know what colour to expect because we
      know the robot's position - black for columns <= 4, yellow for > 4)
   
* The robot knows the direction its traveling and in which direction to turn (left/right/straight).
    * Robot announces in which direction it is turning using built in EV3 speaker system before performing a turn

* Has a linear gear rack system to move the colour sensor if required (in our case, we did not use it)

* Displays the robot's current position within the LCD screen as the physical robot is moving

## Demo

https://user-images.githubusercontent.com/73859429/163320404-83a2fe89-c985-4a15-9952-bf1d8692d689.mp4

## What can't this robot do?
* Currently, this robot is unable to drive at a fast speed due to overshooting

* Robot currently does not a moving Colour Sensor to check at intersection, 
  so it relies entirely on virtually solved path


## What was observed as differences between the virtual and physical twin?
* The virtual is only used to determine the shortest path, and does not require any line tracking code

* The virtual robot is able to go through the maze at a very high speed,
  while the physical robot is constrained by the limitations set by overshooting at increased speeds

* The virtual is more accurate when line tracking compared with the physical 


## Other comments to forward to developers working on this project in the future, or users of this product.
* When creating a robot for the line maze, it is better to have the colour sensor as close to the center of
  rotation as possible
    * This will make your turns more accurate and allows you to line track closer to the intesection
    * Displaying the maze and the robot position on the LCD is exteremely useful for debugging the maze solver

