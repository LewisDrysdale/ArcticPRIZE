
%% Plot deployment and recovery CTD casts and compare to instruments

% PRIZE 18_19 West

clear all
close all

load ../DATA/CTD/JR17006_033_cal_1dbd;
% cast 036 23/06/18 12:23
load ../DATA/CTD/KPH/Sta0417
load ../DATA/CTD/JR18006_012_cal_1dbd_v2;
load ../DATA/CTD/JR18006_013_cal_1dbd_v2;
load ../DATA/CTD/KPH/KPHWcal

%plot all ctd profiles - Temperature

figure
plot(CTD033.CTDtemp1,CTD033.CTDdepth,'r')
set(gca,'ydir','reverse','ylim',[0 250])
ylabel('Depth (m)')
xlabel('Temperature ( ^oC )')
title('CTD casts at PRIZE West mooring 18-19')
hold on
%plot(CTD033.CTDtemp2,CTD033.CTDdepth,'r')
plot(CTD012.CTDtemp1,CTD012.CTDdepth,'b')
%plot(CTD012.CTDtemp2,CTD012.CTDdepth,'b')
plot(CTD013.CTDtemp1,CTD013.CTDdepth,'c')
%plot(CTD013.CTDtemp2,CTD013.CTDdepth,'c')
%plot(CTD417.CTDtemp1,CTD417.CTDdepth,'k')
%plot(CTD417.CTDtemp2,CTD417.CTDdepth,'k')
plot(CTDArcticPrizeWest.CTDtemp,CTDArcticPrizeWest.CTDdepth,'k')
legend('June 2018','July 2019','July 2019','November 2019','location','southwest')
% - salinity

figure
plot(CTD033.CTDsal1,CTD033.CTDdepth,'r')

set(gca,'ydir','reverse','xlim',[34.5 35],'ylim',[0 250])
ylabel('Depth (m)')
xlabel('Salinity (PSU)')
title('CTD casts at PRIZE West mooring 18-19')
hold on

%plot(CTD033.CTDsal2,CTD033.CTDdepth,'r')
plot(CTD012.CTDsal1,CTD012.CTDdepth,'b')
%plot(CTD012.CTDsal2,CTD012.CTDdepth,'b')
plot(CTD013.CTDsal1,CTD013.CTDdepth,'c')
%plot(CTD013.CTDsal2,CTD013.CTDdepth,'c')
%plot(CTD417.CTDtemp1,CTD417.CTDdepth,'k')
%plot(CTD417.CTDtemp2,CTD417.CTDdepth,'k')
plot(CTDArcticPrizeWest.CTDsal,CTDArcticPrizeWest.CTDdepth,'k')
legend('June 2018','July 2019','July 2019','November 2019','location','southwest')
load WEST_18.mat
%extract instrument data at CTD time
%single instrumnet
%casttime=datenum(2018,06,23,12,25,00);


casttime=datenum(2018,06,22,13,50,00);

% ind=find(time50214>casttime);
% n=ind(1:20);
% time50214CTD=time50214(n);
% depth50214CTD=depth50214(n);
% temp50214CTD=temp50214(n);
% cond50214CTD=cond50214(n);
% sal50214CTD=sal50214(n);

%% Deployment
%TEMPERATURE

figure
plot(CTD033.CTDtemp1,CTD033.CTDdepth,'k')
set(gca,'ydir','reverse')
ylabel('Depth (m)')
xlabel('Temperature ( ^oC )')
title('PRIZE West 18-19 deployment CTD moored instrument temperatures')
hold on
%plot(CTD033.CTDtemp2,CTD033.CTDdepth)


%loop through instruments and plot temperatures

%% SBE 37
    
for j=1:length(WEST_SBE37_SN)
    sn = num2str(WEST_SBE37_SN(j));
    
    % find time closest to CTD
    casttime=datenum(2018,06,22,13,30,00); %1/2 hour before cast start
   
    eval(['ind=find(time' sn '>casttime);'])
    n=ind(1:5); % 1 hour across cast
    
    eval(['time' sn 'CTD=time' sn '(n);']);
    eval(['depth' sn 'CTD=depth' sn '(n);']);
    eval(['temp' sn 'CTD=temp' sn '(n);']);
    eval(['cond' sn 'CTD=cond' sn '(n);']);
    eval(['sal' sn 'CTD=sal' sn '(n);']);
  
    eval(['scatter(temp' sn 'CTD,depth' sn 'CTD,''k.'')']);
    l=cellstr(sn);
    
    eval(['text(2.25,depth' sn 'CTD(1),l)']);
    
end

%% Star Oddi

inst_dep_list_so_west=[32.5 36.5 46.5 56.5 66.5 90.5 97 136 161 186];

for j=1:length(WEST_SO_SN)
    sn = num2str(WEST_SO_SN(j));
    
    eval(['depth' sn 'CTD=inst_dep_list_so_west(j);']);
    % find time closest to CTD
    %casttime=datenum(2018,06,23,12,25,00);
   
    eval(['ind=find(time' sn '>casttime);'])
    
    for n=ind(1):2:ind(10) %1 hour across cast
    
    %eval(['time' sn 'CTD=time' sn '(n);']);
    eval(['temp' sn 'CTD=temp' sn '(n);']);
    eval(['scatter(temp' sn 'CTD,depth' sn 'CTD,''r.'')']);
    l=cellstr(sn);
   
    text(3.3,inst_dep_list_so_west(j),l,'Color','r')
    end
    

end

% SALINITY

figure
plot(CTD033.CTDsal1,CTD033.CTDdepth,'b')
set(gca,'ydir','reverse','xlim',[34.8 35.1])
ylabel('Depth (m)')
xlabel('Salinity (PSU)')
title('PRIZE West 18-19 deployment CTD and SBE37 salinity')
hold on
%plot(CTD033.CTDsal2,CTD033.CTDdepth)


%loop through instruments and plot temperatures

%% SBE 37
    
for j=1:length(WEST_SBE37_SN)
    sn = num2str(WEST_SBE37_SN(j));
   
    eval(['ind=find(time' sn '>casttime);'])
    n=ind(1:5); % 1 hour across cast
    
    eval(['time' sn 'CTD=time' sn '(n);']);
    eval(['depth' sn 'CTD=depth' sn '(n);']);
    eval(['temp' sn 'CTD=temp' sn '(n);']);
    eval(['cond' sn 'CTD=cond' sn '(n);']);
    eval(['sal' sn 'CTD=sal' sn '(n);']);
  
    eval(['scatter(sal' sn 'CTD,depth' sn 'CTD,''k.'')']);
    l=cellstr(sn);
    
    eval(['text(34.81,depth' sn 'CTD(1),l)']);
    
end

    
%% Recovery

% TEMPERATURE

figure
%plot(CTD417.CTDtemp1,CTD417.CTDdepth,'k') %% original uncalibrated files
plot(CTDArcticPrizeWest.CTDtemp,CTDArcticPrizeWest.CTDdepth,'k')
set(gca,'ydir','reverse','xlim',[1 4.5])
ylabel('Depth (m)')
xlabel('Temperature ( ^oC )')
title('PRIZE West 18-19 recovery CTD and moored instrument temperatures')
hold on
%plot(CTD417.CTDtemp2,CTD417.CTDdepth,'k')
%plot(CTDArcticPrizeWest.CTDtemp,CTDArcticPrizeWest.CTDdepth,'m')
%loop through instruments and plot temperatures

%% SBE 37
    
for j=1:length(WEST_SBE37_SN)
    sn = num2str(WEST_SBE37_SN(j));
    
    
    %casttime=datenum(2018,06,23,12,25,00);
    
    eval(['ind=length(time' sn ');'])
  
    n=[ind-4:ind]; % last hour of mooring dat (4-5am)
    
    eval(['time' sn 'CTD=time' sn '(n);']);
    eval(['depth' sn 'CTD=depth' sn '(n);']);
    eval(['temp' sn 'CTD=temp' sn '(n);']);
    eval(['cond' sn 'CTD=cond' sn '(n);']);
    eval(['sal' sn 'CTD=sal' sn '(n);']);
  
    eval(['scatter(temp' sn 'CTD,depth' sn 'CTD,''k.'')']);
    l=cellstr(sn);
    
    eval(['text(1.1,depth' sn 'CTD(1),l)']);
    
end

for j=1:length(WEST_SBE37_SN)
    sn = num2str(WEST_SBE37_SN(j));
    
    % plot 12 hours prior to ctd cast
    extime=datenum(2019,11,18,23,30,00);
    
    eval(['ind=find(time' sn '>extime);'])
    n=ind(1:5); % 12 hours earlier than CTD cast
    
    eval(['time' sn 'CTD=time' sn '(n);']);
    eval(['depth' sn 'CTD=depth' sn '(n);']);
    eval(['temp' sn 'CTD=temp' sn '(n);']);
    eval(['cond' sn 'CTD=cond' sn '(n);']);
    eval(['sal' sn 'CTD=sal' sn '(n);']);
  
    eval(['scatter(temp' sn 'CTD,depth' sn 'CTD,''b.'')']);
    
    
    
    
end
for j=1:length(WEST_SBE37_SN)
    sn = num2str(WEST_SBE37_SN(j));
    
    % plot 12 hours prior to ctd cast
    extime=datenum(2019,11,18,11,30,00);
    
    eval(['ind=find(time' sn '>extime);'])
    n=ind(1:5); % 12 hours earlier than CTD cast
    
    eval(['time' sn 'CTD=time' sn '(n);']);
    eval(['depth' sn 'CTD=depth' sn '(n);']);
    eval(['temp' sn 'CTD=temp' sn '(n);']);
    eval(['cond' sn 'CTD=cond' sn '(n);']);
    eval(['sal' sn 'CTD=sal' sn '(n);']);
  
    eval(['scatter(temp' sn 'CTD,depth' sn 'CTD,''c.'')']);
    
    
    
    
 end

%% Star Oddi

inst_dep_list_so_west=[32.5 36.5 46.5 56.5 66.5 90.5 97 136 161 186];

for j=1:length(WEST_SO_SN)
    sn = num2str(WEST_SO_SN(j));
    
    eval(['depth' sn 'CTD=inst_dep_list_so_west(j);']);
    % find time closest to CTD
    %casttime=datenum(2018,06,23,12,25,00);
   
    eval(['ind=length(time' sn ');'])
    
    for n=[ind-9:ind]; % last hour of mooring data (4-5am)
    
    %eval(['time' sn 'CTD=time' sn '(n);']);
    eval(['temp' sn 'CTD=temp' sn '(n);']);
    eval(['scatter(temp' sn 'CTD,depth' sn 'CTD,''r.'')']);
    l=cellstr(sn);
   
    text(1.5,inst_dep_list_so_west(j),l,'Color','r')
    end
    

end

for j=1:length(WEST_SO_SN)
    sn = num2str(WEST_SO_SN(j));
    
    eval(['depth' sn 'CTD=inst_dep_list_so_west(j);']);
    % find time closest to CTD
    %casttime=datenum(2018,06,23,12,25,00);
   
    % plot 12 hours prior to ctd cast
    extime=datenum(2019,11,18,23,30,00);
    
    eval(['ind=find(time' sn '>extime);'])
    for n=ind(1):ind(10); % 12 hours earlier than CTD cast
    
    %eval(['time' sn 'CTD=time' sn '(n);']);
    eval(['temp' sn 'CTD=temp' sn '(n);']);
    eval(['scatter(temp' sn 'CTD,depth' sn 'CTD,''m.'')']);
   
   
    
    end
    

end

for j=1:length(WEST_SO_SN)
    sn = num2str(WEST_SO_SN(j));
    
    eval(['depth' sn 'CTD=inst_dep_list_so_west(j);']);
    % find time closest to CTD
    %casttime=datenum(2018,06,23,12,25,00);
   
    % plot 24 hours prior to ctd cast
    extime=datenum(2019,11,18,11,30,00);
    
    eval(['ind=find(time' sn '>extime);'])
    for n=ind(1):ind(10); % 12 hours earlier than CTD cast
    
    %eval(['time' sn 'CTD=time' sn '(n);']);
    eval(['temp' sn 'CTD=temp' sn '(n);']);
    eval(['scatter(temp' sn 'CTD,depth' sn 'CTD,''y.'')']);
   
   
    
    end
    

end

% SALINITY

figure
%plot(CTD417.CTDsal1,CTD417.CTDdepth,'c') %% original uncalibrated files
plot(CTDArcticPrizeWest.CTDsal,CTDArcticPrizeWest.CTDdepth,'k')
set(gca,'ydir','reverse','xlim',[34.5 35])
ylabel('Depth (m)')
xlabel('Salinity (PSU)')
title('PRIZE West 18-19 recovery CTD and SBE37 salinity')
hold on
%plot(CTD417.CTDsal2,CTD417.CTDdepth,'k')
%plot(CTDArcticPrizeWest.CTDsal,CTDArcticPrizeWest.CTDdepth,'b')
%loop through instruments and plot temperatures

%% SBE 37
    
for j=1:length(WEST_SBE37_SN)
    sn = num2str(WEST_SBE37_SN(j));
    
    eval(['ind=length(time' sn ');'])
  
    n=[ind-4:ind]; % last hour of mooring dat (4-5am)
    
    eval(['time' sn 'CTD=time' sn '(n);']);
    eval(['depth' sn 'CTD=depth' sn '(n);']);
    eval(['temp' sn 'CTD=temp' sn '(n);']);
    eval(['cond' sn 'CTD=cond' sn '(n);']);
    eval(['sal' sn 'CTD=sal' sn '(n);']);
  
    eval(['scatter(sal' sn 'CTD,depth' sn 'CTD,''k.'')']);
    l=cellstr(sn);
    
    eval(['text(34.95,depth' sn 'CTD(1),l)']);
    
end

for j=1:length(WEST_SBE37_SN)
    sn = num2str(WEST_SBE37_SN(j));
    
    % plot 12 hours prior to ctd cast
    extime=datenum(2019,11,18,23,30,00);
    
    eval(['ind=find(time' sn '>extime);'])
    n=ind(1:5); % 12 hours earlier than CTD cast
    
    eval(['time' sn 'CTD=time' sn '(n);']);
    eval(['depth' sn 'CTD=depth' sn '(n);']);
    eval(['temp' sn 'CTD=temp' sn '(n);']);
    eval(['cond' sn 'CTD=cond' sn '(n);']);
    eval(['sal' sn 'CTD=sal' sn '(n);']);
  
    eval(['scatter(sal' sn 'CTD,depth' sn 'CTD,''b.'')']);
    
    
end



%% Middle (visited by JR18006 but couldn't recover)

%TEMPERATURE
figure
plot(CTD012.CTDtemp1,CTD012.CTDdepth,'k')
set(gca,'ydir','reverse','xlim',[0 3],'ylim',[0 250])
ylabel('Depth (m)')
xlabel('Temperature ( ^oC )')
title('PRIZE West 18-19 mid CTD cast and moored instrument temperatures')
hold on
plot(CTD013.CTDtemp1,CTD013.CTDdepth,'r')

%loop through instruments and plot temperatures

%% SBE 37
    
for j=1:length(WEST_SBE37_SN)
    sn = num2str(WEST_SBE37_SN(j));
    
    % plot data either side of cast time
    casttime=datenum(2019,07,21,21,15,00); %21/07/19 21:41:58
    
    eval(['ind=find(time' sn '>casttime);'])
    n=ind(1:5);
    
    eval(['time' sn 'CTD=time' sn '(n);']);
    eval(['depth' sn 'CTD=depth' sn '(n);']);
    eval(['temp' sn 'CTD=temp' sn '(n);']);
    eval(['cond' sn 'CTD=cond' sn '(n);']);
    eval(['sal' sn 'CTD=sal' sn '(n);']);
  
    eval(['scatter(temp' sn 'CTD,depth' sn 'CTD,''k.'')']);
    l=cellstr(sn);
    
    eval(['text(0.1,depth' sn 'CTD(1),l)']);
    
end

%% Star Oddi

inst_dep_list_so_west=[32.5 36.5 46.5 56.5 66.5 90.5 97 136 161 186];

for j=1:length(WEST_SO_SN)
    sn = num2str(WEST_SO_SN(j));
    
    eval(['depth' sn 'CTD=inst_dep_list_so_west(j);']);
    % find time closest to CTD
   
   
    eval(['ind=find(time' sn '>casttime);'])
    for n=ind(1):ind(10);
    
    %eval(['time' sn 'CTD=time' sn '(n);']);
    eval(['temp' sn 'CTD=temp' sn '(n);']);
    eval(['scatter(temp' sn 'CTD,depth' sn 'CTD,''r.'')']);
    l=cellstr(sn);
   
    text(0.5,inst_dep_list_so_west(j),l,'Color','r')
 
    end

end

%Salinity
figure
plot(CTD012.CTDsal1,CTD012.CTDdepth,'b')
set(gca,'ydir','reverse','xlim',[34.2 35],'ylim',[0 250])
ylabel('Depth (m)')
xlabel('Salinity (PSU)')
title('PRIZE West 18-19 mid CTD and SBE37 salinity')
hold on
plot(CTD013.CTDsal1,CTD013.CTDdepth,'k') % change this to calibrated

%loop through instruments and plot temperatures

%% SBE 37
    
for j=1:length(WEST_SBE37_SN)
    sn = num2str(WEST_SBE37_SN(j));
    
    % plot last few data points as pro
    casttime=datenum(2019,07,21,21,42,00); %21/07/19 21:41:58
    
    eval(['ind=find(time' sn '>casttime);'])
    n=ind(1:20);
    
    eval(['time' sn 'CTD=time' sn '(n);']);
    eval(['depth' sn 'CTD=depth' sn '(n);']);
    eval(['temp' sn 'CTD=temp' sn '(n);']);
    eval(['cond' sn 'CTD=cond' sn '(n);']);
    eval(['sal' sn 'CTD=sal' sn '(n);']);
  
    eval(['scatter(sal' sn 'CTD,depth' sn 'CTD,''k.'')']);
    l=cellstr(sn);
    
    eval(['text(34.7,depth' sn 'CTD(1),l)']);
    
end
