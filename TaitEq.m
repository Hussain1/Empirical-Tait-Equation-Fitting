function TaitEq(KnownPoints)
% Input for the function is a path like TaitEq('C:\blah\blah\points.xlsx')
% It will output three Tait Equation Paramters Fit C, B, and A for the form
% V = A + B*ln(1+P/C)
% The Deciding Factor for the optimal C is the max produced error from the
% fit for any point
% Make sure that the excel sheet has the FIRST COLUMN as PRESSURE and 
% the SECOND as VOLUME

% BEGIN FUNCTION
Pset = xlsread(KnownPoints,'A:A'); %define a pressure vector
Vset = xlsread(KnownPoints,'B:B'); %define a volume vector
xset=0; % declare variables to be used
B=0;
A=0;
ErrorSet=0;
ValuesSet = 0;

for C = 2500:0.1:3500; % Set the bounds for  expected C and your step size
    xset = log(1+Pset/C);
    B = (mean(xset.*Vset)-mean(Vset)*mean(xset))/(mean(xset.^2)-(mean(xset).^2));
    A = mean(Vset)-B*mean(xset);
    ErrorSet = Vset-A-B*xset;
    if ValuesSet==0
        ValuesSet = [C,B,A,max(abs(ErrorSet))];
    else
        ValuesSet = [ValuesSet;C,B,A,max(abs(ErrorSet))];
    end
end
[L,P] = min(ValuesSet(:,4));
C=ValuesSet(P,1)
B=ValuesSet(P,2)
A=ValuesSet(P,3)
plot(ValuesSet(:,1),ValuesSet(:,4)) % Plot for the max error vs C
end