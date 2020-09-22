/**************************************************************************************
A gourmet pizza restaurant is considering adding new toppings to its menu. Each month they survey
ten customers to rate their preferences for three different toppings. The SAS data set called
PIZZARATINGS contains data for respondent ID, topping type, and rating.
a. Review the names, labels, and attributes of the variables in the SAS data set PIZZARATINGS.
Record the label and variable type for Rating as a comment in your program.
b. Create a format to be used on the Rating variable so that the data values are presented as n/a
(missing values), never (1), might (2), at least once (3), occasionally (4), and often (5). Apply
this format to a listing of the data set.
c. For each topping type, count the number of nonmissing observations and calculate the average
rating. Present the count as a whole number and the average to three decimal places.
d. Repeat part c) using a different procedure.

***************************************************************************************/

LIBNAME new "/folders/myfolders/sasuser.v94";

PROC CONTENTS data=new.pizzaratings varnum;
RUN;

PROC FORMAT;
	VALUE rating 
	.="N/A" 1="Never" 2="Might" 3="At least once" 4="Occasionally" 5="Often";
RUN;

PROC PRINT data=ch4.pizzaratings;
	FORMAT Rating rating.;
	TITLE "Pizza Topping Survey Data";
RUN;

PROC SORT data=new.pizzaratings out=pizzasort;
	BY Topping;
	WHERE Rating <> .;
RUN;

PROC MEANS data=pizzasort maxdec=3;
	BY Topping;
	VAR Rating;
	TITLE "Mean Pizza Topping Rating Using PROC MEANS";
RUN;

PROC TABULATE data=new.pizzaratings FORMAT=5.3;
	CLASS Topping;
	VAR Rating;
	TABLE Topping, MEAN*Rating;
	TITLE "Mean Pizza Topping Rating Using PROC TABULATE";
RUN;