/****************************************************************************************

The SAS data set named CRAYONS contains information on standard Crayola crayon colors. The
variables in this file are crayon number, color name, hexadecimal code, RGB triplet, pack added,
year issued, and year retired.
a. In a comment in your code, describe two different ways that you could view the variable
attributes in this SAS data set.
b. Using one of the methods described in part a), review the names, labels, and attributes of the
variables in the SAS data set CRAYONS. Record the label and length for the variable Color as a
comment in your program.
c. Calculate the number of colors issued per year. Add a comment to your code stating in which
year the largest number of colors were issued.
d. Sorting the crayons by color using their names would be ineffective due to the uniqueness of
the names, but the information found in the RGB triplets can be used instead. Sort the crayon
data by RGB triplet.
e. Print the sorted data showing only columns for the variables color name and RGB triplet.

*****************************************************************************************/



libname practice "/folders/myfolders/sasuser.v94";

proc print data=practice.crayons;
run;

proc contents data=practice.crayons varnum;
run;

/*
Variable	Type	Len	Label
1	Number	Num	     8	Crayon number
2	Color	Char	 26	Crayon name
3	Hex	    Char	 8	HEX  triplet
4	RGB	    Char	 15	RGB  codes
5	Pack	Num		 8	Pack added
6	Issued	Num		 8	Year issued
7	Retired	Num		 8	Year retired */
proc freq data=practice.crayons;
	table Issued;
run;

PROC SORT data=practice.crayons out=crayons_sort 
		SORTSEQ=LINGUISTIC (NUMERIC_COLLATION=ON);
	BY RGB;
RUN;

PROC PRINT data = crayons_sort NOOBS;
	VAR Color RGB;
RUN;