####~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
####
#### Create Simple two resistor BJT bias network
####	- Assumes common emitter setup
####	
####	Vcc	Vcc
####	 | 	 |
####	[Rb]	[Rc]
####	 | 	 |
####	 --------[Q]
####		 |
####		[Gnd]
#### Output:
####	- Resistor values - Rb and Rc
####	- Ic_sat, saturation current (load line y-intercept)
####	- Vce_off, pinch off voltage (load line x-intercept)
#### Input: 
####	Vcc - Supply voltage 
####	Vceq - Bias voltage
####	Iceq - Bias current
####	Bdc - DC current gain (Ic=Bdc*Ib) (datasheet)
####	Vbeq - Base to emitter voltage drop (like a diode) (datasheet)
#### Usage:
####	1) [Rb,Rc,Ic_sat,Vce_off] = calcBJTBiasBasic(Vcc,Vceq,Icq,Vbeq,Bdc)
####		- No outputs sent to terminal
####		- Intended for use in parent script	
####	2) calcBJTBiasBasic()
####		- Specify input parameters inside calcBJTBiasBasic.m
####		- Outputs displayed in terminal
####
#### curtis
#### calcBJTBiasBasic.m
#### Last Edited: 4/26/11
####~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function [Rb,Rc,Ic_sat,Vce_off] = calcBJTBiasBasic(varargin)

#--------------------------------------------------
# Inputs
#
switch (nargin)
case 5
	Vcc = varargin{1};
	Vceq = varargin{2};
	Icq = varargin{3};
	Vbeq = varargin{4};
	Bdc = varargin{5};
	display_outputs = false;
case 0
	# Supply voltage
	# choose according to absolute max Vce voltage (Vce_sat=Vcc)
	# and desired load line slope (X-intercept=Vcc)
	Vcc = 4;  		# volts
	
	# Bias point
	Vceq = 2;  		# volts
	Icq = 10*(1e-3);   	# A
	
	# From datasheet
	Vbeq = 0.84;  		# voltage drop across base-emitter (at bias point)
	Bdc = 280;  		# DC current gain (at bias point)
	
	display_outputs = true;
otherwise
	warning("incorrect number of arguments to function calcBJTBiasBasic.m")
	warning("Usage:    [Rb,Rc,Ic_sat,Vce_off] = calcBJTBiasBasic(Vcc,Vceq,Icq,Vbeq,Bdc)")
endswitch


#--------------------------------------------------
# Calculate resistor values
#
Rc = (Vcc-Vceq)/Icq;		# voltage division
Rb = (Bdc*(Vcc-Vbeq))/Icq;	# Bdc/Icq = Ib

#--------------------------------------------------
# Find saturation current and pinch off voltage
# gives X & Y intercept for plotting load line
#
Ic_sat = Vcc/Rc;			# A
Ic_sat_mA = Ic_sat*(1e3);		# mA, Y-intercept
Vce_off = Vcc;				# V, X-intercept
LL_slope = (0-Ic_sat)/(Vce_off-0);	# mA/V, slope of load line 
					# less slope can mean higher efficiency

#--------------------------------------------------
# Calc base current (for verification)
#
Ib = (Vcc-Vbeq)/Rb;		# A
Ib_uA = Ib*(1e6);		# uA

#--------------------------------------------------
# Output to terminal
#
if(display_outputs)
	printf("\n");

	printf("----Input Parameters---------------\n");
	printf("Vcc: %2.2f V - Supply voltage\n",Vcc);
	printf("Vceq: %2.2f V - Bias voltage\n",Vceq);
	printf("Icq: %2.2f mA - Bias current\n",Icq*(1e3));
	printf("Vbeq: %2.2f V - Base-emitter drop\n",Vbeq);
	printf("Bdc: %2.2f  - DC current gain\n",Bdc);
	printf("\n");

	printf("----Resistor Values----------------\n");
	printf("Rc: %2.2f ohms - Resistor at collector\n",Rc);
	printf("Rb: %2.2f ohms - Resistor at base\n",Rb);
	printf("\n");

	printf("----Load Line----------------------\n");
	printf("Ic_sat: %2.2f mA - Y-intercept\n",Ic_sat*(1e3));
	printf("Vce_off: %2.2f V - X-intercept\n",Vce_off);
	printf("Slope: %2.2f mA/V - slope of load line\n",LL_slope*(1e3));
	printf("-----------------------------------\n");

endif


endfunction


