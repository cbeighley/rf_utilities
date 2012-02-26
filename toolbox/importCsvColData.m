####~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
####
#### Import data and column headings from .csv file (comma delimited form)
#### - Excell can save and load files in .csv format
#### - If first entry of first row is a letter, assume first row contains titles (column headings)
#### - If first entry of first row is a number, assume data starts on first row
#### - Intended for use with importCsvFolder.m
####
#### Input:
#### - 1 argument: Assume single argument is the filename and is located in current folder
#### - 2 arguments: Assume first argument is the folder name and second argument is the filename
####
#### Outputs:
#### - data: data matrix
#### - titles: cell array of column headings. titles = "" if file does not have column headings
####
#### Usage: 
#### data = importCsvColData('filename.csv');
#### [data,titles] = importCsvColData('foldername','filename.csv');
####
#### Example .csv file:
#### ---------powerSweep.csv-----------
#### freq,Pin,Pout,Efficiency
#### 1.8,5,21,35
#### 1.8,6,22,34
#### 2.2,5,23,31
#### 2.2,6,24,30
#### ----------------------------------
####
#### curtis
#### importCsvColData.m
#### Last Edited: 10/2/11
####~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function [data,titles] = importCsvColData(varargin)

#----------------------------------------
# Save input arguments to proper variables
#	
switch(nargin)
case 1
	folder = ".";
	filename = varargin{1};
	file_loc = [filename];
case 2
	folder = varargin{1};
	filename = varargin{2};
	file_loc = [folder,"/",filename];
otherwise
	warning("function: importCsvColData");
	warning("Incorrect number of arguments");
	warning("Usage: data = importCsvColData('filename.txt')");
	warning("Usage: [data,titles] = importCsvColData('foldername','filename.txt')");
endswitch

#----------------------------------------
# Initialize
#
titles{1} = "";
data = [];
data_row_start = 2;
alph = ["abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"];	# all letters
numbers = ["-","1","2","3","4","5","6","7","8","9"];			# all numbers and negative sign

#----------------------------------------
# Warn the user if the target folder does not exist
#
if(!isdir(folder))
warning(["Could not find the directory [ ",folder," ]"]);
endif

#----------------------------------------
# Warn the user if the target file does not exist
#
[info, err, msg] = stat(file_loc);
if(err)
warning(["Could not load [ ",file_loc," ]"]);
warning(msg);
return;
endif

#----------------------------------------
# Import first row of the target file
#
fid = fopen (file_loc);					# open file
txt = fgetl (fid);					# import first row
fclose (fid);						# close file
titles = strsplit(txt,",");				# cell array (1 row)
	#titles2 = strsplit(txt,",")'			# cell array (1 col)
	#titles3 = char(strsplit(txt,","))		# matrix of letters (each row is a different title)
	#titles4 = cellstr(strsplit(txt,","))		# cell array (1 row) - same as above
num_titles = length(titles);				# number of titles/columns

#----------------------------------------
# Does the first row contain titles?
# Test the first entry of the first row to see
# if it is a letter.
#
char_titles = char(titles);						# convert cell array to character matrix
alph_titles = [char_titles(1,1) == alph(:)];				# test first entry for letter match
num_titles = [char_titles(1,1) == numbers];				# test first entry for number match
first_row_isalph = any(alph_titles);					# is the first entry a letter?
first_row_isnum = any(num_titles);					# is the first entry a number?

#----------------------------------------
# Does the data start in the first or second row?
#
if(first_row_isalph && !first_row_isnum)				# if first entry is a letter
	data_start_row = 2;						# start data selection from second row
elseif(!first_row_isalph && first_row_isnum)				# if first entry is a number
	data_start_row = 1;						# start data selection from first row
	titles = "";
else									# something is wrong
	data_start_row = 2;						# assume title row exists by default
	printf("\n****function: importCsvColData\n");			# first entry is not a number of letter
	printf("****first entry is not a number or letter\n")		#
endif									#

#----------------------------------------
# Import data
#
data = dlmread(file_loc,",");						# Import comma delimited data from file
[num_rows,num_cols] = size(data);					# find number of rows and columns
data = data(data_start_row:num_rows,1:num_cols);			# strip titles if they exist

endfunction
