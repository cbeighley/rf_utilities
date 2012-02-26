####~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
####
#### Convert dBm to watts
####
#### Input:
#### dBm - numerical value
#### 	
#### Output:
#### watts - numerical value
####
#### Usage:
#### watts = dbm2watt(dbm)
####
#### curtis
#### dbm2watt.m
#### Last Edited: 8/15/11
####~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function watts = dbm2watt(dbm)
	watts = (1e-3)*(10^(dbm/10));
endfunction




