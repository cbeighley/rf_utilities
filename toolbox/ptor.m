####~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
####
#### Convert polar to rectangular
####
#### Usage: 
#### 	rect = ptor(mag,ang_degrees)
####
####
#### curtis
#### ptor.m
#### Last Edited: 1/5/11
####~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function rect = ptor(mag,ang_degrees)

	ang_radians = ang_degrees*(pi/180);
	imaginary = 0+1i;

	R = mag*cos(ang_radians);
	X = mag*sin(ang_radians);

	rect = R+(X*imaginary);

endfunction
