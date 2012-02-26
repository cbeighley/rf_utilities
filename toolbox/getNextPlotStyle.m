####~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
####
#### Get a different line style describing how a curve looks when plotted
#### - intended for use with plot()
#### - This allows a plot to easily be created with many different looking curves
####
#### Input: 
#### One of the following....
#### ["k","r","g","b","m","c",
#### "-*k","-*r","-*g","-*b","-*m","-*c",
#### "-ok","-or","-og","-ob","-om","-oc"];
####
#### Output:
####	The next color in the array
####
#### Example Usage:
#### x = linspace(1,10,10);
#### y1 = linspace(1,50,10);
#### plot_style = "k";
#### plot(x,y1,plot_style);
#### hold on;
#### plot_style = getNextPlotStyle(plot_style)
#### y2 = y1*2;
#### plot(x,y2,plot_style);
#### hold off;
####
#### curtis
#### getNextPlotStyle.m
#### Last Edited: 9/30/11
####~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function next_style = getNextPlotStyle(current_style)

style_options = {"k","r","g","b","m","c","-*k","-*r","-*g","-*b","-*m","-*c","-ok","-or","-og","-ob","-om","-oc"};
#style_options = {"k","r","b","m","-*k","-*r","-*b","-*m","-ok","-or","-ob","-om"};

num_options = length(style_options);				# number of style options
current_ind = strcmp(current_style,style_options);		# current_style match equal to 1
current_loc = find(current_ind);				# loc of current style
next_loc = current_loc+1;					# add 1 to current index

if(!any(current_ind))						# if input is not an option
next_loc = 1;							# use default
printf("**[ %c ] is not a color option\n",current_style);	#
printf("**options: k,r,g,b,m,c\n");				#
printf("**using default of k\n");				#
endif

if(next_loc > num_options)					# if out of options
next_loc = 1;							# start at beginning
endif								#

next_style = style_options{next_loc};				# set output

endfunction
