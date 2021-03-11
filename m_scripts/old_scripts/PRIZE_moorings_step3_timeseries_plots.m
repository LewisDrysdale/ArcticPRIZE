% Quick plots of PRIZE 2017-18 moorings data
% ESDU, Sep 18

clear; close all;


%% EAST

load EAST_18.mat

% Setup figures
figure('units','normalized','outerposition',[0 0 1 1]);
figure('units','normalized','outerposition',[0 0 1 1]);
figure('units','normalized','outerposition',[0 0 1 1]);
figure('units','normalized','outerposition',[0 0 1 1]);

for j=1:length(EAST_SBE_SN)
    

    
    % Plot
    figure(1)
    subplot(length(EAST_SBE_SN),1,j)
    
    plot(mtime(ind),temp(ind),'b')
    grid on
    ylim([-2 5])
    title (['Temperature EAST - ' num2str(EAST_SBE37_depth(j)) 'm']);
    ylabel('Temp (^oC)');
    datetick('x','mmm-yy')
    
    figure(2)
    subplot(length(EAST_SBE37_SN),1,j)
    plot(mtime(ind),sal(ind),'r')
    grid on
    ylim([32 35.5])
    title (['Salinity EAST - ' num2str(EAST_SBE37_depth(j)) 'm']);
    ylabel('Salinity (psu)');
    datetick('x','mmm-yy')
    
    clear scan timeJ pres temp cond depth sal dens flag mtime ind
    
end




%% WEST
clear

WEST_start = datenum('22-Jun-2018 12:00:00');
WEST_end = datenum('25-Nov-2019 06:00:00');
WEST_SBE37_SN = [9382,9395,7294,7295,9396];
WEST_SBE37_depth = [26,55.5,77.5,111,221];

% Setup figures
figure('units','normalized','outerposition',[0 0 1 1]);
figure('units','normalized','outerposition',[0 0 1 1]);

for j=1:length(WEST_SBE37_SN)
    
    % Read data
        fl = ['WEST18_SBE37_' num2str(WEST_SBE37_SN(j)) '.cnv'];
        [scan,timeJ,pres,temp,cond,depth,sal,dens,flag]=textread(fl,...
            '%f%f%f%f%f%f%f%f%f','headerlines',300);
    
    % Select in-water data only
    mtime=datenum('31-Dec-2017 00:00:00')+timeJ;
    ind=find(mtime>=WEST_start & mtime<=WEST_end);
    
    % Plot
    figure(3)
    subplot(length(WEST_SBE37_SN),1,j)
    plot(mtime(ind),temp(ind),'b')
    grid on
    ylim([-2 7])
    title (['Temperature WEST - ' num2str(WEST_SBE37_depth(j)) 'm']);
    ylabel('Temp (^oC)');
    datetick('x','mmm-yy')
    
    figure(4)
    subplot(length(WEST_SBE37_SN),1,j)
    plot(mtime(ind),sal(ind),'r')
    grid on
    ylim([32 35.5])
    title (['Salinity WEST - ' num2str(WEST_SBE37_depth(j)) 'm']);
    ylabel('Salinity (psu)');
    datetick('x','mmm-yy')
    
     clear scan timeJ pres temp cond depth sal dens fluo par flag mtime ind
end

% % To zoom in with date labels:
% set(gca,'xtick',EAST.start_date:1:EAST.end_date)
% grid on
% datetick('x','dd-mmm','keepticks')
