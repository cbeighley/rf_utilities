####~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
####
#### Create circles for a smith chart
#### Call at the start of a script
#### Then add stuff to it
#### hold is not turned off and should be later
####
#### R -> Real_Axis=R/(1+R); -- Imaginary_Axis=0.0; -- Radius=1/(1+R)
#### X -> Real_Axis=1.0; ------ Imaginary_Axis=1/X; -- Radius=1/X
####
#### Usage:
####	scCreate
####	scCreate(option,value)
####
#### Options:
####	scCreate("plot_Y_chart","true")
####
#### Changes: 
####	Accept variable input arguments
####	Added option "plot_Y_chart" -> "true" or "false"
####
#### curtis
#### scCreate.m
#### Last modified: 4/25/11
####~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function scCreate(varargin)

#---------------------------------------------------------
# Chart Properties
#
circles = [0.2, 0.4, 0.6, 0.8, 1, 2, 4, 6, 8, 10];	# circle values (r,g)
arcs =    [0.2, 0.4, 0.6, 0.8, 1, 2, 4, 6, 8, 10];	# arc values (x,s)

Z_color = "k"; 						# Z chart color
Y_color = "g";						# Y chart color

plot_Z_chart = 1;					# 1 is true
plot_Y_chart = 0;					# 0 is false

add_Z_labels = 1;					# add label values to chart
add_Y_labels = 1;					#

#---------------------------------------------------------
# Modify Properties if input arguments exist
#
if(nargin)
	printf("%i input arguments were passed\n",nargin)
	for narg = [1:2:nargin]					# every other argument should be an option

	switch (varargin{narg})
	case "plot_Y_chart"
	plot_Y_chart = varargin{narg+1}
	case 'figure'
	fignum = varargin{narg+1}
	otherwise
	printf("input arguments did not match valid options\n")
	endswitch

	endfor
endif


#---------------------------------------------------------
# vectors required to produce circles and lines
#
t = [0:0.01:2*pi];
x = cos(t);
y = sin(t);
line = t.*0;
	
#---------------------------------------------------------
# Prepare Chart
#
if (exist('fignum') == 1)
  figure(fignum);
else
  figure(1)
end
hold on;						# hold on
plot(x,line,"k");					# vertical line
#plot(line,y,"k");					# horizontal line
plot(x,y,"k");						# gamma=1 circle
axis([-1,1,-1,1],"square")
replot


#---------------------------------------------------------
# Create Z Smith Chart
#
if(plot_Z_chart)

	for R = circles 					# add circles
	re_axis = R/(1+R);					#
	im_axis = 0;						#
	radius = 1/(1+R);					#
	plot(((x*radius)+re_axis),((y*radius)+im_axis),Z_color)	#

	text(re_axis-radius,im_axis-0.02,num2str(R))
	endfor

	for X = arcs						# add upper arcs
	re_axis = 1;						#
	im_axis = 1/X;						#
	radius = 1/X;						#
	plot(((x*radius)+re_axis),((y*radius)+im_axis),Z_color)	# 

	X = -X;							# add lower arcs
	re_axis = 1;						#
	im_axis = 1/X;						#
	radius = 1/X;						#
	plot(((x*radius)+re_axis),((y*radius)+im_axis),Z_color) # 
	endfor

	if(add_Z_labels)					# label chart
	addLabels(circles,arcs)					#
	endif							#
	
endif



#---------------------------------------------------------
# Create Y Smith Chart
#
if(plot_Y_chart)

	for R = circles 					# add circles
	re_axis = -R/(1+R);					# negative for Y
	im_axis = 0;						#
	radius = 1/(1+R);					# 
	plot(((x*radius)+re_axis),((y*radius)+im_axis),Y_color)	# 
	endfor

	for X = arcs						# add upper arcs
	re_axis = -1;						# negative for Y
	im_axis = 1/X;						#
	radius = 1/X;						#
	plot(((x*radius)+re_axis),((y*radius)+im_axis),Y_color)	# 

	X = -X;							# add lower arcs
	re_axis = -1;						# negative for Y
	im_axis = 1/X;						#
	radius = 1/X;						#
	plot(((x*radius)+re_axis),((y*radius)+im_axis),Y_color) # 
	endfor

endif



######## Old method
#
#plot(((x*(1/1.2))+(0.2/1.2)),((y*(1/1.2))+(0.0)),"k")	# R=0.2  circle
#plot(((x*(1/1.5))+(0.5/1.5)),((y*(1/1.5))+(0.0)),"k") 	# R=0.5  circle
#plot(((x*(1/2))+(1/2)),((y*(1/2))+(0.0)),"k") 		# R=1  circle
#plot(((x*(1/3))+(2/3)),((y*(1/3))+(0.0)),"k") 		# R=2  circle
#plot(((x*(1/4))+(3/4)),((y*(1/4))+(0.0)),"k") 		# R=3  circle
#plot(((x*(1/0.2))+(1.0)),((y*(1/0.2))+(1/0.2)),"k") 	# X=0.2  circle
#plot(((x*(1/0.5))+(1.0)),((y*(1/0.5))+(1/0.5)),"k") 	# X=0.5  circle
#plot(((x*(1/1))+(1.0)),((y*(1/1))+(1/1)),"k") 		# X=1  circle
#plot(((x*(1/2))+(1.0)),((y*(1/2))+(1/2)),"k") 		# X=2  circle
#plot(((x*(1/-0.2))+(1.0)),((y*(1/-0.2))+(1/-0.2)),"k") # X=-0.2  circle
#plot(((x*(1/-0.5))+(1.0)),((y*(1/-0.5))+(1/-0.5)),"k") # X=-0.5  circle
#plot(((x*(1/-1))+(1.0)),((y*(1/-1))+(1/-1)),"k")	# X=-1 circle
#plot(((x*(1/-2))+(1.0)),((y*(1/-2))+(1/-2)),"k")	# X=-2  circle
endfunction


function addLabels(circles,arcs)

for R = circles 						# for each circle value
re_axis = R/(1+R);						#
im_axis = 0;							#
radius = 1/(1+R);						#
text(re_axis-radius,im_axis-0.02,num2str(R))			# add circle label
endfor								#

for X = arcs							# for each arc value
label_loc = ((X*i)-1)/((X*i)+1);				# convert to refl coef
text(real(label_loc)+0.01,imag(label_loc),num2str(X))		# add upper arc label
text(real(label_loc)+0.01,(-1)*imag(label_loc),num2str(X))	# add arc label
endfor								#

endfunction


