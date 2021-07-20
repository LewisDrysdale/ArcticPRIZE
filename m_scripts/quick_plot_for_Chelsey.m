clear all; close('all');

load('C:\Users\sa01ld\Desktop\PRIZE_18_19\data/moor_processed/WEST_17.mat')
figure; % line plot
subplot(2,1,1)
h1=plot(prize_west_17_gridded.time_grid,prize_west_17_gridded.sal(1,:))
hold on
h2=plot(prize_west_17_gridded.time_grid,prize_west_17_gridded.sal(7,:))
hold on
h3=plot(prize_west_17_gridded.time_grid,prize_west_17_gridded.sal(9,:))
hold on
h4=plot(prize_west_17_gridded.time_grid,prize_west_17_gridded.sal(12,:))
ylabel('Salinity (PSU)')
xlabel('Time')
datetick('x')
legend([h1 h2 h3 h4],'SBE16 21 m',...
    'SBE37 112 m','SBE37 162 m','SBE37 222 m',...
    'Location','southeast')


subplot(2,1,2)
h1=plot(prize_west_17_gridded.time_grid,prize_west_17_gridded.temp(1,:))
hold on
h2=plot(prize_west_17_gridded.time_grid,prize_west_17_gridded.temp(7,:))
hold on
h3=plot(prize_west_17_gridded.time_grid,prize_west_17_gridded.temp(9,:))
hold on
h4=plot(prize_west_17_gridded.time_grid,prize_west_17_gridded.temp(12,:))
ylabel('Temperature (deg C)')
xlabel('Time')
datetick('x')
legend([h1 h2 h3 h4],'SBE16 21 m','SBE37 112 m','SBE37 162 m','SBE37 222 m')

print(gcf,'-dpng','../plots/T_S_lineplot_west17.png')


figure; % ts plot
[X,Y]=meshgrid([33.0:.05:35.5],[-1.0:0.05:7.0]);
dens0 = sw_dens0(X,Y)-1000;
[c,l]=contour(X,Y,dens0,'--k','LineWidth',0.5);
clabel(c,l,'LabelSpacing',240,'Color','k');
hold on
h1=plot(prize_west_17_gridded.sal(1,:),prize_west_17_gridded.temp(1,:),'.')
hold on
h2=plot(prize_west_17_gridded.sal(7,:),prize_west_17_gridded.temp(7,:),'.')
hold on
h3=plot(prize_west_17_gridded.sal(9,:),prize_west_17_gridded.temp(9,:),'.')
hold on
h4=plot(prize_west_17_gridded.sal(11,:),prize_west_17_gridded.temp(12,:),'.')
ylabel('Temperature (deg C)')
xlabel('Salinity (PSU)')

legend([h1 h2 h3 h4 ],'SBE16 21 m',...
    'SBE37 112 m','SBE37 162 m','SBE37 222 m',...
    'Location','northwest')

print(gcf,'-dpng','../plots/T_S_west17.png')
