####~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
####
#### Get random color
####	- intended for use with plot()
####
#### Output:
####	One of the following....
####	["k","r","g","b","m","c"]
#### Usage:
####	color = getRandomColor
####
#### curtis
#### getRandomColor.m
#### Last Edited: 4/13/11
####~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function color = getRandomColor()

color_options = ["k","r","g","b","m","c"];	# color options
random_num = round(5*rand)+1;			# random number from 1 to 6
color = color_options(random_num);		# random color

endfunction
