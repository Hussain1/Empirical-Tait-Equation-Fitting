# Empirical-Tait-Equation-Fitting
The purpose of this project is to prepare a code that will calculate the three emprical parameters used in the Tait equation of state based on the lowest absolute error between the correlation and the MD simulation generated points

# TaitEq V1
This  code takes an input of known pressure and volume points and uses a linear regression to calculate the parameters in the linear part of the equation, while brute forcing the non-linear part (Intel Core i7 FTW)
Input for the function is a path like TaitEq('C:\blah\blah\points.xlsx')
# It will output three Tait Equation Paramters Fit C, B, and A for the form
# V = A + B*ln(1+P/C)

The Deciding Factor for the optimal C is the max produced error from the fit for all points
Make SURE THAT THE EXCEL SHEET HAS THE FIRST COLUMN AND PRESSURE AND THE
SECOND AS VOLUME WITH NO ADDITION THINGS IN THE FIRST TWO COLUMNS
