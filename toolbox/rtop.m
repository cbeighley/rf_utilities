####~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
####
#### Convert rectangular coordinates to polar form
####
#### Usage: 
#### 	[mag,ang] = rtop(rect)
####
####
#### curtis
#### rtop.m
#### Last Edited: 6/12/11
####~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function [mag,ang] = rtop(rect)

	mag = abs(rect);		# magnitude
	ang_rad = angle(rect);		# angle in radians
	ang = ang_rad*(180/pi);		# angle in degrees

endfunction
