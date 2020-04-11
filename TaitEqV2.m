function TaitEqV2(KnownPoints,L,H)
format long
% TaitEq V10
% This code takes an input of known pressure and volume points and
% uses a mix of linear algebra and brute force to fit parameters
% Use it like TaitEqV2('C:\blah\blah\points.xlsx',L,H)
% 'C:\blah\blah\points.xlsx' is path to the xlsx sheet sandwiched in ''
% L and H are two bounds where you expect your Tait Equation C parameter to
% be
% It will output three Tait Equation Paramters Fit C, B, and A for the form
% V = A + B*ln(1+P/C)
% V, A and B are in cm3/mol. P is in bar.
% The Deciding Factor for the optimal C is the RMSE from the known points
% Make sure that the excel sheet has the FIRST COLUMN as PRESSURE and  
% the SECOND as VOLUME with no additional things anywhere

Pset = xlsread(KnownPoints,'A:A'); %define a pressure vector from the Excel sheet
Vset = xlsread(KnownPoints,'B:B'); %define a volume vector

% declare variables to be used
xset=0; 
[n,~] = size(Pset);
C=0;
B=0;
A=0;
K=0;
ErrorSet=0;
ValuesSet = 0;
VisualRMSEset =0;


%start secret sauce formula here
for i = 0:20
    if i == 0 % Initially we create a genesis ValuesSet matrix by using the the L and H provided
        for C = L:((H-L)/1000):H; % Set the bounds for your expected C and an accuracy of (H-L)/1000
            xset = log(1+Pset/C); %this line and the next two are just some nifty linear algebra
            B = (mean(xset.*Vset)-mean(Vset)*mean(xset))/(mean(xset.^2)-(mean(xset).^2));
            A = mean(Vset)-B*mean(xset);
            ErrorSet = ((Vset-A-B*xset).^2); %define the RMSE vector of the current C for our known points
            if ValuesSet==0 %start building the matrix which will contain the parameters and the RMSE
                ValuesSet = [C,B,A,(((sum(ErrorSet))/n).^0.5)];
            else
                ValuesSet = [ValuesSet;C,B,A,(((sum(ErrorSet))/n).^0.5)];
            end
        end
        VisualRMSEset = ValuesSet; %better to graph the RMSE using the current version of ValuesSet as with higher i it will become a data dump
    else
        [~,K] = min(ValuesSet(:,4)); %find location of minimum error in the genesis matrix to run more iterations
        for C = (ValuesSet(K,1))*(1-0.01/i):((ValuesSet(K,1))*(0.02/i))/100:(ValuesSet(K,1))*(1+0.01/i); %with higher i, the bounds get smaller and so does the step
            xset = log(1+Pset/C);
            B = (mean(xset.*Vset)-mean(Vset)*mean(xset))/(mean(xset.^2)-(mean(xset).^2));
            A = mean(Vset)-B*mean(xset);
            ErrorSet = ((Vset-A-B*xset).^2);
            ValuesSet = [ValuesSet;C,B,A,(((sum(ErrorSet))/n).^0.5)];
        end
    end
end
%end secret sauce formula here

% Below we extract the parameters with the lowest RMSE
[~,K] = min(ValuesSet(:,4));
C=ValuesSet(K,1)
B=ValuesSet(K,2)
A=ValuesSet(K,3)
Error=ValuesSet(K,4)

%below we graph the results to better visualize
figure % Plot for the RMSE vs C
plot(VisualRMSEset(:,1),VisualRMSEset(:,4)) 
title('RMSE Error vs C')
xlabel('C')
ylabel('RMSE')
figure % Plot Tait Equation fit overlayed on simulation points
Pset2=[-1000:100:2500]; % Define your pressure range for Tait Fit
plot(Pset,Vset,'o',Pset2,(A+B*log(1+Pset2/C))) 
title('Simulation Points Overlayed on Tait Equation Fit')
xlabel('Pressure')
ylabel('Volume')
end
%HB
