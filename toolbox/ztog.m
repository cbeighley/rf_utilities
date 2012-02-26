####~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
####
#### Convert impedance to reflection coeff.
####
#### Input:	
####	ZL - load impedance
####	zL - load impedance (normalized)
####	Zo - characteristic impedance
#### Output:
####	reflmag = reflection coeff. magnitude
####	reflang = reflection coeff. angle
#### Usage:
#### 	1 Argument  
####		-> assumed to be normalized impedance
####		[reflmag,reflang] = gtoz(zL)
####	2 Arguments 
####		-> first argument is assumed to be an unnomalized impedance
####		-> second argument is assumed to be the characteristic impedance
####		[reflmag,reflang] = gtoz(ZL,Zo)
####
####
#### curtis
#### gtoz.m
#### Last Edited: 5/5/11
####~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function [reflmag,reflang] = ztog(varargin)

#---------------------------------------------------------
# Inputs
#
switch (nargin)
case 1
	zL = varargin{1};
#	refl = (zL-1)/(zL+1);
case 2
	ZL = varargin{1};
	Zo = varargin{2};
	zL = ZL/Zo;
#	refl = (ZL-Zo)/(ZL+Zo);
otherwise
	warning("incorrect number of arguments to function ztog.m")
	warning("Usage:")
	warning("	[reflmag,reflang] = gtoz(ZL,Zo)")
	warning("	[reflmag,reflang] = gtoz(zL)")
endswitch

#---------------------------------------------------------
# Calculation
#
refl = (zL-1)/(zL+1);
reflmag = abs(refl);
reflang = angle(refl)*(180/pi);

endfunction




