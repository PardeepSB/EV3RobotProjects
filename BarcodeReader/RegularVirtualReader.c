#pragma config(StandardModel, "EV3_REMBOT")
//*!!Code automatically generated by 'ROBOTC' configuration wizard               !!*//



task main()
{
	//move bot out of start area
	setMotorTarget(leftMotor, 650, 20);
	setMotorTarget(rightMotor, 650, 20);
	waitUntilMotorStop(rightMotor);
	waitUntilMotorStop(leftMotor);

	//set speed to 20 and clear datalog
	setMotorSpeed(leftMotor, 20);
	setMotorSpeed(rightMotor, 20);
	datalogClear();


	//initialize local variable
	int i = 0;


	while(true)
	{

		//checks that 4 black and white bars have been read by the robot
	  //if 4 iterations have been completed AND colour sensor reads white, loop is broken
		if( (i > 3) && (getColorReflected(colorSensor)>70)){
			setMotorSpeed(leftMotor, 0);
			setMotorSpeed(rightMotor, 0);
			break;
		}

		//while light reflected off black bar, save all values in datalog
		while (getColorReflected(colorSensor) <= 70){
			datalogDataGroupStart();
		  datalogAddValue(0, getColorReflected(colorSensor));
		 	datalogDataGroupEnd();
		 	sleep(50);
		}

		//while light reflected off white bar, save all values in datalog
		while (getColorReflected(colorSensor) > 70){
			if(i > 0){
				datalogDataGroupStart();
			 	datalogAddValue(0, getColorReflected(colorSensor));
			 	datalogDataGroupEnd();
			 	sleep(50);
			}
			//if on last black bar, move forward for 25 iterations and add to datalog
			if ( i > 3){
				for(i = 0;i<25;i++){
					datalogDataGroupStart();
			  	datalogAddValue(0, getColorReflected(colorSensor));
			  	datalogDataGroupEnd();
			  	sleep(50);
				}
				break;
			}
		}
		i++;
	}
}
