/*****************************************************************************************
The Coastal Humane Society is preparing their year-end donation receipts for each person who
contributed money during the year. The raw data file Donations.dat contains variables to identify
the donor ID, first and last name, and their address information as well as individual records for
each amount and month donated.
a. After examining the raw data file, read the file Donations.dat into SAS.
b. Create a text file containing one report for each donor using the following example for
variables, formats, text, and layout.

******************************************************************************************/


DATA donations;
	INFILE "/folders/myfolders/sasuser.v94/Donations.dat" TRUNCOVER;
	INPUT id 1-4 first $ 6-19 last $ 20-33 address $ 34-58 city $ 59-88 zip $ 94-98 amount 101-105 month 106-107 ;
RUN;

DATA donations_fill;
	SET donations;

	RETAIN _first _last _address _city _zip;
	IF NOT MISSING(first) THEN _first = first;
	IF NOT MISSING(last) THEN _last = last;
	IF NOT MISSING(address) THEN _address = address;
	IF NOT MISSING(city) THEN _city = city;
	IF NOT MISSING(zip) THEN _zip = zip;

	first = _first;
	last = _last;
	address = _address;
	city = _city;
	zip = _zip;

	DROP _:;
RUN;

PROC MEANS data = donations_fill NOPRINT; 
	VAR amount ;
	BY id first last address city zip month;
	OUTPUT OUT = donations_summary
				sum(amount)=;
RUN;

