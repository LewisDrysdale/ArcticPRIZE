
%% Plot deployment and recovery CTD casts and compare to instruments

% PRIZE 18_19 East

clear all
close all

load ../DATA/CTD/JR17006_036_cal_1dbd;
% cast 036 23/06/18 12:23
load ../DATA/CTD/KPH/Sta0338.mat
load ../DATA/CTD/KPH/KPHEcal

%plot all ctd profiles - Temperature

figure
plot(CTD036.CTDtemp1,CTD036.CTDdepth,'r')
set(gca,'ydir','reverse')
ylabel('Depth (m)')
xlabel('Temperature ( ^oC )')
title('CTD casts at PRIZE East mooring 18-19')
hold on
%plot(CTD036.CTDtemp2,CTD036.CTDdepth,'r')

plot(CTDArcticPrizeEast.CTDtemp,CTDArcticPrizeEast.CTDdepth,'k')
%legend('June 2018','November 2019','location','northeast')
% - salinity

figure
plot(CTD036.CTDsal1_cal,CTD036.CTDdepth,'r')

set(gca,'ydir','reverse','xlim',[34 35])
ylabel('Depth (m)')
xlabel('Salinity (PSU)')
title('CTD casts at PRIZE East mooring 18-19')
hold on

%plot(CTD036.CTDsal2_cal,CTD036.CTDdepth,'b')

plot(CTDArcticPrizeEast.CTDsal,CTDArcticPrizeEast.CTDdepth,'k')
legend('June 2018','November 2019','location','southwest')

load EAST_18.mat
%extract instrument data at CTD time
%single instrumnet
%casttime=datenum(2018,06,23,12,25,00);
%SBE16 0nly records ever 2 hours so round casttime back
%Look for nearest neighbour option?

casttime=datenum(2018,06,23,11,30,00); % minus half an hour for full coverage

ind=find(time50214>casttime);
n=ind(1);
time50214CTD=time50214(n);
depth50214CTD=depth50214(n);
temp50214CTD=temp50214(n);
cond50214CTD=cond50214(n);
sal50214CTD=sal50214(n);


%% TEMPERATURE

figure
plot(CTD036.CTDtemp1,CTD036.CTDdepth,'k')
set(gca,'ydir','reverse','xlim',[-1.2 1])
ylabel('Depth (m)')
xlabel('Temperature (^oC)')
title('PRIZE East 18-19 deployment CTD and moored instrument temperatures')
hold on
plot(CTD036.CTDtemp2,CTD036.CTDdepth,'r')
scatter(temp50214CTD,depth50214CTD,'k*')

text(0.8,depth50214CTD(1),'50214');


%loop through instruments and plot temperatures

%% SBE 37
    
for j=1:length(EAST_SBE37_SN)
    sn = num2str(EAST_SBE37_SN(j));
    
    % find time closest to CTD
    %casttime=datenum(2018,06,23,12,25,00);
   
    eval(['ind=find(time' sn '>casttime);'])
    n=ind(1:5); % 1 hour straddling cast time
    
    eval(['time' sn 'CTD=time' sn '(n);']);
    eval(['depth' sn 'CTD=depth' sn '(n);']);
    eval(['temp' sn 'CTD=temp' sn '(n);']);
   
    
  
    eval(['scatter(temp' sn 'CTD,depth' sn 'CTD,''k.'')']);
    l=cellstr(sn);
    
    eval(['text(0.8,depth' sn 'CTD(1),l)']);
end


%% Star Oddi

inst_dep_list_so_east=[28 32 42 52 62 83 95 124 139 154];

for j=1:length(EAST_SO_SN)
    sn = num2str(EAST_SO_SN(j));
    
    eval(['depth' sn 'CTD=inst_dep_list_so_east(j);']);
    % find time closest to CTD
    %casttime=datenum(2018,06,23,12,25,00);
   
    eval(['ind=find(time' sn '>casttime);'])
    
    for n=ind(1):ind(10) % 1 hour at 6 min sample rate
    
    %eval(['time' sn 'CTD=time' sn '(n);']);
    eval(['temp' sn 'CTD=temp' sn '(n);']);
    eval(['scatter(temp' sn 'CTD,depth' sn 'CTD,''r.'')']);
    l=cellstr(sn);
   
    text(0.8,inst_dep_list_so_east(j),l,'Color','r')
    end
    
    
end


%% Salinity

figure
plot(CTD036.CTDsal1_cal,CTD036.CTDdepth,'c')
set(gca,'ydir','reverse','xlim',[34 35])
ylabel('Depth (m)')
xlabel('Temperature (^oC)')
title('PRIZE East 18-19 deployment CTD and moored instrument salinity')
hold on
plot(CTD036.CTDsal2_cal,CTD036.CTDdepth,'c')
scatter(sal50214CTD,depth50214CTD,'k*')

text(34.9,depth50214CTD(1),'50214');


%loop through instruments and plot Salinity

%% SBE 37
    
for j=1:length(EAST_SBE37_SN)
    sn = num2str(EAST_SBE37_SN(j));
    
    % find time closest to CTD
    %casttime=datenum(2018,06,23,12,25,00);
   
    eval(['ind=find(time' sn '>casttime);'])
    n=ind(1:5);
    
%     eval(['time' sn 'CTD=time' sn '(n);']);
%     eval(['depth' sn 'CTD=depth' sn '(n);']);
%     eval(['temp' sn 'CTD=temp' sn '(n);']);
%     eval(['cond' sn 'CTD=cond' sn '(n);']);
    eval(['sal' sn 'CTD=sal' sn '(n);']);
  
    eval(['scatter(sal' sn 'CTD,depth' sn 'CTD,''b.'')']);
    l=cellstr(sn);
    
    eval(['text(34.9,depth' sn 'CTD(1),l)']);
end

%% recovery

casttime=datenum(2019,11,18,18,00,00);

ind=find(time50214<casttime); %cast was after recovery
n=length(ind)-5:length(ind); %last few data points
%n=ind(end);
time50214CTD=time50214(n);
depth50214CTD=depth50214(n);
temp50214CTD=temp50214(n);
cond50214CTD=cond50214(n);
sal50214CTD=sal50214(n);

figure
%plot(CTD338.CTDtemp1,CTD338.CTDdepth,'k') % uncalibrated
plot(CTDArcticPrizeEast.CTDtemp,CTDArcticPrizeEast.CTDdepth,'r')
set(gca,'ydir','reverse') %,'xlim',[-1.2 1]
ylabel('Depth (m)')
xlabel('Temperature (^oC)')
title('PRIZE East 18-19 recovery CTD and moored instrument temperatures')
hold on
%plot(CTD338.CTDtemp2,CTD338.CTDdepth,'k')

scatter(temp50214CTD,depth50214CTD,'k*')

text(4.1,depth50214CTD(1),'50214');


%loop through instruments and plot temperatures

%% SBE 37
    
for j=1:length(EAST_SBE37_SN)
    sn = num2str(EAST_SBE37_SN(j));
    
    % find time closest to CTD
    %casttime=datenum(2018,06,23,12,25,00);
   
    eval(['ind=find(time' sn '<casttime);'])
    n=[ind(end)-5:ind(end)];
    
    eval(['time' sn 'CTD=time' sn '(n);']);
    eval(['depth' sn 'CTD=depth' sn '(n);']);
    eval(['temp' sn 'CTD=temp' sn '(n);']);
    eval(['cond' sn 'CTD=cond' sn '(n);']);
    eval(['sal' sn 'CTD=sal' sn '(n);']);
  
    eval(['scatter(temp' sn 'CTD,depth' sn 'CTD,''k.'')']);
    l=cellstr(sn);
    
    eval(['text(4.1,depth' sn 'CTD(1),l)']);
end
for j=1:length(EAST_SBE37_SN)
    sn = num2str(EAST_SBE37_SN(j));
    
    % 12 hours earlier
    extime=datenum(2019,11,18,06,00,00);
   
     eval(['ind=find(time' sn '>extime);'])
     n=[ind(1):ind(5)];
    
    eval(['time' sn 'CTD=time' sn '(n);']);
    eval(['depth' sn 'CTD=depth' sn '(n);']);
    eval(['temp' sn 'CTD=temp' sn '(n);']);
    eval(['cond' sn 'CTD=cond' sn '(n);']);
    eval(['sal' sn 'CTD=sal' sn '(n);']);
  
    eval(['scatter(temp' sn 'CTD,depth' sn 'CTD,''b.'')']);
   
end
for j=1:length(EAST_SBE37_SN)
    sn = num2str(EAST_SBE37_SN(j));
    
    % 24 hours earlier
    extime=datenum(2019,11,17,18,00,00);
   
     eval(['ind=find(time' sn '>extime);'])
     n=[ind(1):ind(5)];
    
    eval(['time' sn 'CTD=time' sn '(n);']);
    eval(['depth' sn 'CTD=depth' sn '(n);']);
    eval(['temp' sn 'CTD=temp' sn '(n);']);
    eval(['cond' sn 'CTD=cond' sn '(n);']);
    eval(['sal' sn 'CTD=sal' sn '(n);']);
  
    eval(['scatter(temp' sn 'CTD,depth' sn 'CTD,''c.'')']);
    
end

%% Star Oddi

inst_dep_list_so_east=[28 32 42 52 62 83 95 124 139 154];


    
    

for j=1:length(EAST_SO_SN)
    sn = num2str(EAST_SO_SN(j));
    
    eval(['depth' sn 'CTD=inst_dep_list_so_east(j);']);
    
   
    eval(['ind=find(time' sn '<casttime);'])
    
    for n=ind(end)-10:ind(end);
    
    %eval(['time' sn 'CTD=time' sn '(n);']);
    eval(['temp' sn 'CTD=temp' sn '(n);']);
    eval(['scatter(temp' sn 'CTD,depth' sn 'CTD,''r.'')']);
    l=cellstr(sn);
   
    text(6,inst_dep_list_so_east(j),l,'Color','r')
    end
    
    
end
for j=1:length(EAST_SO_SN)
    sn = num2str(EAST_SO_SN(j));
    
    eval(['depth' sn 'CTD=inst_dep_list_so_east(j);']);
    
   
    % 12 hours earlier
    extime=datenum(2019,11,18,06,00,00);
   
     eval(['ind=find(time' sn '>extime);'])
     for n=[ind(1):ind(5)];
    
    %eval(['time' sn 'CTD=time' sn '(n);']);
    eval(['temp' sn 'CTD=temp' sn '(n);']);
    eval(['scatter(temp' sn 'CTD,depth' sn 'CTD,''m.'')']);
    
     end
   
   
end

for j=1:length(EAST_SO_SN)
    sn = num2str(EAST_SO_SN(j));
    
    eval(['depth' sn 'CTD=inst_dep_list_so_east(j);']);
    
   
    % 24 hours earlier
    extime=datenum(2019,11,17,18,00,00);
   
     eval(['ind=find(time' sn '>extime);'])
     for n=[ind(1):ind(10)];
    
    %eval(['time' sn 'CTD=time' sn '(n);']);
    eval(['temp' sn 'CTD=temp' sn '(n);']);
    eval(['scatter(temp' sn 'CTD,depth' sn 'CTD,''y.'')']);
    l=cellstr(sn);
   
   
    end    
end   
%% Salinity

figure
plot(CTDArcticPrizeEast.CTDsal,CTDArcticPrizeEast.CTDdepth,'c')
%plot(CTD338.CTDsal1,CTD338.CTDdepth,'c')
set(gca,'ydir','reverse','xlim',[33.8 35.1])
ylabel('Depth (m)')
xlabel('Temperature (^oC)')
title('PRIZE East 18-19 recovery CTD cast and SBE salinity')
hold on

%plot(CTD338.CTDsal2,CTD338.CTDdepth,'c')
scatter(sal50214CTD,depth50214CTD,'k*')

text(34.9,depth50214CTD(1),'50214');


%loop through instruments and plot 
%% SBE 37
    
for j=1:length(EAST_SBE37_SN)
    sn = num2str(EAST_SBE37_SN(j));
    
    
  
    eval(['scatter(sal' sn 'CTD,depth' sn 'CTD,''k.'')']);
    l=cellstr(sn);
    
    eval(['text(34.9,depth' sn 'CTD(1),l)']);
end

for j=1:length(EAST_SBE37_SN)
    sn = num2str(EAST_SBE37_SN(j));
    
    % 12 hours earlier than CTD
    extime=datenum(2019,11,18,06,00,00);
   
     eval(['ind=find(time' sn '>extime);'])
     n=[ind(1):ind(5)];
   
     eval(['time' sn 'CTD=time' sn '(n);']);
     eval(['depth' sn 'CTD=depth' sn '(n);']);
     eval(['temp' sn 'CTD=temp' sn '(n);']);
     eval(['cond' sn 'CTD=cond' sn '(n);']);
     eval(['sal' sn 'CTD=sal' sn '(n);']);
  
    eval(['scatter(sal' sn 'CTD,depth' sn 'CTD,''b.'')']);
    
    
   
end
for j=1:length(EAST_SBE37_SN)
    sn = num2str(EAST_SBE37_SN(j));
    
    % 24 hours earlier than CTD
    extime=datenum(2019,11,17,18,00,00);
   
     eval(['ind=find(time' sn '>extime);'])
     n=[ind(1):ind(5)];
   
     eval(['time' sn 'CTD=time' sn '(n);']);
     eval(['depth' sn 'CTD=depth' sn '(n);']);
     eval(['temp' sn 'CTD=temp' sn '(n);']);
     eval(['cond' sn 'CTD=cond' sn '(n);']);
     eval(['sal' sn 'CTD=sal' sn '(n);']);
  
    eval(['scatter(sal' sn 'CTD,depth' sn 'CTD,''c.'')']);
    
    
   
end
