####~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
####
#### Convert between gamma, return loss, and VSWR
#### 
#### Inputs:
#### argument 1: "gamma", "rl", or "vswr"
#### argument 2: numerical value
####
#### Accepted values for first argument.....
#### To enter gamma: "gamma","Gamma","refl_coef"
#### To enter return_loss: "rl","RL","Rl","return_loss","Return_Loss"
#### To enter vswr: "VSWR","Vswr","vswr"
####
#### Outputs:
#### [gamma, RL(db), vswr]
####
#### Usage:
#### [gamma,RL,vswr] = gamma2rl2vswr("gamma",0.333) 
#### [gamma,RL,vswr] = gamma2rl2vswr("RL",11.3)
#### [gamma,RL,vswr] = gamma2rl2vswr("vswr",2)
####
#### If the function is called with a number of arguments other than 2, it will
#### calculate a range of values.  The full matrix will be
#### printed to the terminal and each return variable will be an 
#### array of related values.
#### Usage: 
#### [gamma,RL,vswr] = gamma2rl2vswr
####
#### Notes: 
#### gamma is another name for the reflection coeff.
#### gamma is a scalar magnitude value.  No angle needed.
####
#### curtis
#### refl2rf2vswr.m
#### Last Edited: 8/15/11
####~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function [gamma,RL,vswr] = gamma2rl2vswr(varargin)

#---------------------------------------
# Initialize variables
#
options_gamma = {"gamma","Gamma","refl_coef"};			# input argument #1 options
options_RL = {"rl","RL","Rl","return_loss","Return_Loss"};	#
options_vswr = {"VSWR","Vswr","vswr"};				#
gamma = 1;							# init values are not significant
RL = 1;								#
vswr = 1;							#
num_points = 100;						# when calculating complete table

#---------------------------------------
# Save input arguments or proceed to calculate a range of values
#
switch(nargin)
case 2
input_var = varargin{1};
input_val = varargin{2};
otherwise
input_var = "list_all";
input_val = 0;
printf("\nPrint reference table of each variable\n")
endswitch

#---------------------------------------
# Determine type of input and calculate return values
#
switch(input_var)
case options_gamma
	gamma = input_val;
	RL = -20*log10(gamma);
	vswr = (1+gamma)/(1-gamma);
case options_RL
	RL = input_val;
	gamma = 10^(RL/-20);
	vswr = (1+gamma)/(1-gamma);
case options_vswr
	vswr = input_val;
	gamma = (vswr-1)/(vswr+1);
	RL = -20*log10(gamma);
case "list_all"
	gamma = linspace(0,1,num_points);
	RL = -20*log10(gamma);
	vswr = (1+gamma)./(1-gamma);
	column_headings = {"gamma","RL","vswr"}'
	output_matrix = [gamma',RL',vswr']
otherwise
	printf("\n********************************************\n");
	printf("****First argument is NOT a valid option****\n");
	printf("Accepted values for first argument.....\n");
	printf('"gamma","Gamma","refl_coef"\n');
	printf('"rl","RL","Rl","return_loss","Return_Loss"\n');
	printf('"VSWR","Vswr","vswr"\n');
	printf("********************************************\n\n");
endswitch

endfunction





