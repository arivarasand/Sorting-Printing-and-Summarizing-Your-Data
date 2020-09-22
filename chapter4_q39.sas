/*

The United States Bureau of Labor Statistics publishes various indexes that measure average prices
of consumer goods in urban areas. The SAS data set called GAS contains data on the average price
of unleaded regular gasoline (per gallon) for recent years by month in the United States. The
variables in this file are year, month, and average gasoline price.
a. Review the names, labels, and attributes of the variables in the SAS data set GAS. Record the
37
label and variable type for GasPrice as a comment in your program.
b. Identify the minimum and maximum gasoline price per year. Present the price statistics to two
decimal places.
c. Calculate the average and standard deviation of gasoline prices per quarter per year. Present
the price statistics to two decimal places.
d. Create a SAS data set that contains the averages and standard deviations as calculated in part c).
Print the data set showing only the year, quarter, average price, and standard deviation.
Present the price statistics with a dollar sign and two decimal places.
*/

data gas;
infile "/folders/myfolders/sasuser.v94/Donations.dat"
input ID 


Numeric variable length 8. */
PROC CONTENTS data = ch4.gas;
RUN;

/* Calculate min, max, mean, and std with default PROC MEANS */
PROC MEANS data = ch4.gas
	MAXDEC=2;
	BY Year;
	VAR GasPrice;
RUN;

/* Create a new dataset with quarter */
DATA gas_qtr;
	SET ch4.gas;
	DummyDate = MDY(Month, 01, Year);
	Qtr = QTR(DummyDate);
	DROP DummyDate;
RUN;


PROC MEANS data = gas_qtr
	MAXDEC=2;
	BY Year Qtr;
	VAR GasPrice;
	OUTPUT OUT = gas_summary(DROP = _FREQ_ _TYPE_)
		MEAN(GasPrice) = AveragePrice 
		STD(GasPrice) = StdDev
	;
	FORMAT AveragePrice DOLLAR6.2
		   StdDev DOLLAR6.2;
RUN;