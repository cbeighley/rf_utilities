####~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
####
#### Convert watts to dbm
####
#### Input:
#### watts - numerical value
#### 	
#### Output:
#### dbm - numerical value
####
#### Usage:
#### dbm = watt2dbm(watt)
####
#### curtis
#### watt2dbm.m
#### Last Edited: 8/15/11
####~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function dbm = watt2dbm(watt)
	dbm = 10*log10(watt/(1e-3));
endfunction




