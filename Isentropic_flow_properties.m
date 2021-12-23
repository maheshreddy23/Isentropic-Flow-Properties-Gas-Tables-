tic
clc;clear;close all;
% -----------------------Variables----------------------%
% M = Mach number
% tbto = Ratio of Static temperature to Stagnation temperature
% pbpo = Ratio of Static pressure to Stagnation pressure
% dbdo = Ratio of Static Density to Stagnation Density
% tbts = Ratio of Static temperature to Critical temperature
% pbps = Ratio of Static pressure to Critical pressure
% dbds = Ratio of Static Density to Critical Density
% abas = Area ratio of the flow passage.

% Isentropic Relations
fid = fopen('Isentropic flow properties.txt','w'); % Opening a document to write the output.
gamma = input("Enter the value of gamma:"); %Taking input from the user.
fprintf(fid,'Isentropic flow properties\t\t\tgamma = %f\n',gamma); % Prinitng the first two lines in the file. 
fprintf(fid,"M               T/T0            P/P0            D/D0            T/T*            P/P*            D/D*            A/A*\n");
M = 0:0.1:5; %creating range for mach number
tbto = (zeros(size(M)))'; % Predefininng the sizes of the varaibles for the range of the Mach numbers
pbpo = (zeros(size(M)))';
dbdo = (zeros(size(M)))';
tbts = (zeros(size(M)))';
pbps = (zeros(size(M)))';
dbds = (zeros(size(M)))';
abas = (zeros(size(M)))';
for i = M
    a = gamma - 1;
    b = a*i^2;
    c = gamma/a;
    d = gamma+1;
    e = 1/i;
% using the stagnation temperature to static temperature ratio = 1+{(gamma-1)/2}*M^2
    temp_ratio = 1+(b/2);
    press_ratio = (temp_ratio)^c;
    dens_ratio = (temp_ratio)^(1/a);
% adding the inverse of temperature ratio as an row element to the tbto vector 
    tbto(M==i) = (1/temp_ratio);
% adding the inverse of pressure ratio as an row element to the pbpo vector    
    pbpo(M==i) = (1/press_ratio);
% adding the inverse of density ratio as an row element to the dbdo vector    
    dbdo(M==i) = (1/dens_ratio);
    crit_temp_ratio = d/(2+(a*i^2));
    crit_press_ratio = (crit_temp_ratio)^c;
    crit_dens_ratio = (crit_temp_ratio)^(1/a);
    crit_area_ratio = e*((2+a*i^2)/d)^(d/(2*a));
    tbts(M==i) = crit_temp_ratio;
    pbps(M==i) = crit_press_ratio;
    dbds(M==i) = crit_dens_ratio;
    abas(M==i) = crit_area_ratio;
    fprintf(fid,"%f\t\t%f\t\t%f\t\t%f\t\t%f\t\t%f\t\t%f\t\t%f\n",i,1/temp_ratio,1/press_ratio,1/dens_ratio,crit_temp_ratio,crit_press_ratio,crit_dens_ratio,crit_area_ratio);
%     fprintf("%f\t\t%f\t\t%f\t\t%f\n",M,temp_ratio,press_ratio,dens_ratio)
end
% Creating a table file consisting all the properties
varn = {'M','T/T0','P/P0','D/D0','T/T*','P/P*','D/D*','A/A*'};
t = table(M',tbto,pbpo,dbdo,tbts,pbps,dbds,abas,'VariableNames',varn);
writetable(t,'Isentropic properties Table.txt')
% Graphing the data obtained.
figure(1)
subplot(2,2,1)
hold on 
plot(M,tbto,'k-','LineWidth',2)
plot(M,pbpo,'r-','LineWidth',2)
plot(M,dbdo,'m-','LineWidth',2)
hold off
legend('T/T0','P/P0','D/D0','Location','northeast')
xlabel('M')
ylabel('T/T0,P/P0,D/D0')
title('Isentropic relations')
subplot(2,2,2)
hold on 
plot(M,tbts,'k-','LineWidth',2)
plot(M,pbps,'r-','LineWidth',2)
plot(M,dbds,'m-','LineWidth',2)
legend('T/T*','P/P*','D/D*','Location','northeast')
xlabel('M')
ylabel('T/T*,P/P*,D/D*')
title('Isentropic critical relations')
hold off
subplot(2,2,3)
hold on 
plot(M,tbto,'k-','LineWidth',2)
plot(M,pbpo,'r-','LineWidth',2)
plot(M,dbdo,'m-','LineWidth',2)
plot(M,abas,'y-','LineWidth',2)
legend('T/T0','P/P0','D/D0','A/A*','Location','northeast')
xlabel('M')
ylabel('T/T0,P/P0,D/D0,A/A*')
title('Isentropic relations')
hold off
subplot(2,2,4)
hold on 
plot(M,tbts,'k-','LineWidth',2)
plot(M,pbps,'r-','LineWidth',2)
plot(M,dbds,'m-','LineWidth',2)
plot(M,abas,'y-','LineWidth',2)
legend('T/T*','P/P*','D/D*','A/A*','Location','northeast')
xlabel('M')
ylabel('T/T*,P/P*,D/D*,A/A*')
title('Isentropic critical relations')
hold off
figure(2)
hold on 
plot(M,tbto,'k-','LineWidth',2)
plot(M,pbpo,'r-','LineWidth',2)
plot(M,dbdo,'m-','LineWidth',2)
legend('T/T0','P/P0','D/D0','Location','northeast')
xlabel('M')
ylabel('T/T0,P/P0,D/D0')
title('Isentropic relations')
hold off
figure(3)
hold on 
plot(M,tbts,'k-','LineWidth',2)
plot(M,pbps,'r-','LineWidth',2)
plot(M,dbds,'m-','LineWidth',2)
legend('T/T*','P/P*','D/D*','Location','northeast')
xlabel('M')
ylabel('T/T*,P/P*,D/D*')
title('Isentropic critical relations')
hold off
figure(4)
hold on 
plot(M,tbto,'k-','LineWidth',2)
plot(M,pbpo,'r-','LineWidth',2)
plot(M,dbdo,'m-','LineWidth',2)
plot(M,abas,'y-','LineWidth',2)
legend('T/T0','P/P0','D/D0','A/A*','Location','northeast')
xlabel('M')
ylabel('T/T0,P/P0,D/D0,A/A*')
title('Isentropic relations')
hold off
figure(5)
hold on 
plot(M,tbts,'k-','LineWidth',2)
plot(M,pbps,'r-','LineWidth',2)
plot(M,dbds,'m-','LineWidth',2)
plot(M,abas,'y-','LineWidth',2)
legend('T/T*','P/P*','D/D*','A/A*','Location','northeast')
xlabel('M')
ylabel('T/T*,P/P*,D/D*,A/A*')
title('Isentropic critical relations')
hold off
toc