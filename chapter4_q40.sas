/*

The World Health Organization (WHO) collected data in countries across the world regarding the
outbreak of swine flu cases and deaths in 2009. The data in the SAS data set called SFF includes
information on cases and deaths per country by month during the epidemic.
a. Review the names, labels, and attributes of the variables in the SAS data set SFF. Record the
name and length of the character variables as a comment in your program.
b. Count the number of countries within each continent.
c. Count the number of countries per continent that reported no cases during the first month of
the outbreak (April) versus the number of countries per continent that had at least one case. Do
the same for the last month of the outbreak (August).
d. To find potential errors in the data, create a report for countries that reported a first death date,
but reported no first case date. This output should include only the variables continent,
country, first case date, last reported number of cases, and first death date.
e. Add code that will organize the report from part d) so that the countries on the same continent
are grouped together, and make sure that dates are presentable.
*/
LIBNAME new "U:\Little-SAS-Book-Exercises-And-Projects\data\EPLSB5data\Chapter4_data";

* Part A - Character Variables ;
* Country (length 30), Continent (length 13) ;
PROC CONTENTS data = new.sff varnum;
RUN;

* Part B - Count the number of countries within each continent. ;
PROC FREQ data = new.sff;
	TABLES Continent;
	TITLE "Frequency of Countries by Continent";
RUN; 

* Part C - Count the number of countries per continent that reported no ;
* cases during the first month of outbreak (April) versus those that had at ;
* least one outbreak.  Do the same for August ;

* No April outbreaks ;
PROC FREQ data = ch4.sff;
	TABLES Continent;
	TITLE "Frequency of Countries with No Outbreaks in April by Continent";
	WHERE Apr = .;
RUN; 

* 1+ April outbreaks ;
PROC FREQ data = ch4.sff;
	TABLES Continent;
	TITLE "Frequency of Countries with 1+ Outbreaks in April by Continent";
	WHERE Apr > 0;
RUN; 

* No August outbreaks ;
PROC FREQ data = ch4.sff;
	TABLES Continent;
	TITLE "Frequency of Countries with No Outbreaks in August by Continent";
	WHERE Aug = .;
RUN; 

* 1+ August outbreaks ;
PROC FREQ data = new.sff;
	TABLES Continent;
	TITLE "Frequency of Countries with 1+ Outbreaks in August by Continent";
	WHERE Aug > 0;
RUN; 

* Part D - Create a report of countries that reported a first death date but ;
* did not a first case date.  Only include continent, country, first case date, ;
* last reported number of cases, and first death date ;
PROC PRINT data = ch4.sff;
	VAR Continent Country FirstCase FirstDeath;
	WHERE FirstCase = . AND FirstDeath <> .;
	TITLE "Countries with FirstDeath Date and no First Case Date";
	FORMAT FirstDeath MMDDYY10.;
RUN;

* Part E - Same as part D but format dates and sort output by continent;
PROC SORT data = new.sff out = sffsort;
	BY Continent;
RUN;

PROC PRINT data = sffsort;
	VAR Continent Country FirstCase FirstDeath;
	WHERE FirstCase = . AND FirstDeath <> .;
	TITLE "Countries with FirstDeath Date and no First Case Date";
	FOOTNOTE "Sorted by Continent";
	FORMAT FirstDeath MMDDYY10.;
RUN;
