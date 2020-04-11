# Empirical-Tait-Equation-Fitting
The purpose of this project is to prepare a code that will calculate the three empirical parameters used in the Tait equation of state fit for a set of simulated pressures and volumes based on the lowest RMSE between the correlation and the MD simulation generated points. The Tait equation form this code fits to is the following:

**V = A + B*ln(1+P/C)**

-----------------------------------------------------------

### TaitEq V2
This code takes an input of simulated pressure and volume points (in the form of .xlsx sheet) and uses a linear regression to calculate the parameters in the linear part of the equation, while brute forcing the non-linear part. I added a small algorithm I came up with to save time and resources. It will first run the calculations once with low accuracy. Then it will take the output of the first run, make a range out of it (eg 90% of it till 110%) and run 19 more times, decreasing the range each time along with the step size. It will output the optimal C, B and A fit parameters along with two graphs. One showing how the fit looks like with the simulated points overlayed on it, and one showing how the RMSE correlates with C.

Input for the function is a path like TaitEq2('C:\blah\blah\points.xlsx', L, H). L is the lower end of the expected range, and H is the high end. These two points are user inputted. Just give a range of where you expected your C to be. If you don't know, you can just give an obnoxious range.
##### It will output three Tait Equation Parameters C(bar), B(cm3/mol), and A(cm3/mol) for the follwoing form (V being the volume in cm3/mol and P being in bar)


The Deciding Factor for the optimal C is the RMSE from the fit when comparing it to the known points

Make sure that the excel sheet has the FIRST COLUMN as PRESSURE and the SECOND as VOLUME with no additional things anywhere in the first two columns. The L you will

![Example on how to run it and what kind of output you should expect](https://raw.githubusercontent.com/Hussain1/Empirical-Tait-Equation-Fitting/New-Version/Usage-and-Output-Example.png)
