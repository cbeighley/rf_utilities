####~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
####
#### Convert reflection coeff. to impedance
####
#### need to make it work without Zo input, to just output z, not Z
####
#### Input:	
#### 	reflmag - Reflection coeff. magnitude
#### 	reflang - Reflection coeff. angle in degrees
#### 	Zo - Characteristic impedance
#### Output:
####	Z - impedance
####	z - normalized impedance (for smith chart)
#### Usage:
####	[z,Z] = gtoz(reflmag,reflang,Zo)
#### 	z = gtoz(reflmag,reflang,Zo)
####
#### curtis
#### gtoz.m
#### Last Edited: 5/5/11
####~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function [z,Z] = gtoz(refl_mag,refl_ang,Zo)

	refl_rect = ptor(refl_mag,refl_ang);	# convert to rectangular coordinates

	z = (1+refl_rect)/(1-refl_rect);	# convert refl coeff. to normalized impedance

	Z = z*Zo;				# un-normalized impedance

endfunction




