############################################################################
## Project: EDA - Individual household electric power consumption
## Analyst: Larry
## Date: October, 25, 2020
## Goal: Create plots to analyze Individual household electric power 
## consumption Data Set.
############################################################################


############
STUDY DESIGN
############

- The readme.md file indicates the source of the raw data.
- The readme.md file indicates how the individual plots are developed. Code is
  separated into individual files.
- Results are posted into a forked repository.


#########
CODE BOOK
#########


Transformations
---------------
- The as.<functions> in the dplyr mutate statements converted the ? (for missing
values) to NA


Variables: 
----------

The readme.md file describes the variables.

ID  ||	VARIABLE_NAME       ||	TYPE  	||	UNITS     	||	NOTES
----||---------------------	||	------	||	----------	||	----------
1   ||Date                 	||	Date  	||	          	||	dd/mm/yyyy
2   ||Time                 	||	Time  	||	          	||	hh:mm:ss  
3   ||Global_active_power  	||	double	||	kilowatts 	||	
4   ||Global_reactive_power	||	double	||	kilowatts 	||	
5   ||Voltage              	||	double	||	volts     	||	
6   ||Global_intensity     	||	double	||	amperes   	||	
7   ||Sub_metering_1       	||	double	||	watt-hours	||	
8   ||Sub_metering_2       	||	double	||	watt-hours	||	
9   ||Sub_metering_3       	||	double	||	watt-hours	||	


