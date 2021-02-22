% Create array for CTD data for PRIZE EAST mooring 2017-18

clear all;

addpath C:\MATLAB\seawater
%addpath C:\Code\Matlab\Various
addpath C:\Moorings\PRIZE\PRIZE_18_19\matlab\EAST

mooring_id='EAST_18';
start_date=datenum('20-Jun-2018 12:00:00');
end_date=datenum('18-Nov-2019 14:05:00'); 
waterdepth = 184;

inst_list = [50214,4254,7289,4255,4256,4258,4259,7290,4284,4285,7291,4286,4287,4288,7292]; % Need to add SBE16 when data is available
inst_depth_list = [21,31,35,35.5,45,55,65,76,83,96,110,125,140,155,170];
EAST_SBE37_SN = [7289,7290,7291,7292];
EAST_SO_SN = [4254,4255,4256,4258,4259,4284,4285,4286,4287,4288];
% include SBE16 in generic SBE instrument list (to include in salinity
% plots later
EAST_SBE_SN=[50214 EAST_SBE37_SN];

%% Read SBE16+ data
% 
 fl='EAST18_SBE16_50214.txt';
 sn = '50214';
 
[scan,timeJ,pres,temp,cond,depth,sal,dens,fluo,par,flag]=textread(fl,...
     '%f%f%f%f%f%f%f%f%f%f%f','headerlines',20);
 
 % Select in-water data only
 mtime=datenum('31-Dec-2017 00:00:00')+timeJ;
 ind=find(mtime>=start_date & mtime<=end_date);
 
 % Rename variables
 eval(['time' sn '=mtime(ind);']);
 eval(['pres' sn '=pres(ind);']);
 eval(['temp' sn '=temp(ind);']);
 eval(['cond' sn '=cond(ind);']);
 eval(['depth' sn '=depth(ind);']);
 eval(['sal' sn '=sal(ind);']);
 eval(['dens' sn '=dens(ind);']);
 eval(['fluo' sn '=fluo(ind);']);
 eval(['par' sn '=par(ind);']);
% 
% clear scan timeJ pres temp cond depth sal dens fluo par flag mtime ind sn fl 
%% Read SBE37 data

for j=1:length(EAST_SBE37_SN)
    
    sn = num2str(EAST_SBE37_SN(j));
    fl = ['EAST18_SBE37_' sn '.cnv'];
    
    [scan,timeJ,pres,temp,cond,depth,sal,dens,flag]=textread(fl,...
        '%f%f%f%f%f%f%f%f%f','headerlines',293);    
    
    % Select in-water data only
    mtime=datenum('31-Dec-2017 00:00:00')+timeJ;
    ind=find(mtime>=start_date & mtime<=end_date);
    
    % Rename variables
    eval(['time' sn '=mtime(ind);']);
    eval(['pres' sn '=pres(ind);']);
    eval(['temp' sn '=temp(ind);']);
    eval(['cond' sn '=cond(ind);']);
    eval(['depth' sn '=depth(ind);']);
    eval(['sal' sn '=sal(ind);']);
    eval(['dens' sn '=dens(ind);']);

    clear scan timeJ pres temp cond depth sal dens flag mtime ind sn fl
    
end


%% Read Star-Odi

for j=1:length(EAST_SO_SN)
    
    sn = num2str(EAST_SO_SN(j));
    fl = ['T' sn '.DAT'];
    
    [scan,datetime,temp]=textread(fl,'%f%19c%f','delimiter',' ','headerlines',12);
    mtime=datenum(datetime,'dd.mm.yyyy HH:MM:SS');
    
    ind=find(mtime>=start_date & mtime<=end_date);
    
        % Rename variables
    eval(['time' sn '=mtime(ind);']);
    eval(['temp' sn '=temp(ind);']);

    clear scan datetime temp mtime ind sn fl
    
end

clear j 

%% Save data
eval(['save(''' mooring_id '.mat'');']);

