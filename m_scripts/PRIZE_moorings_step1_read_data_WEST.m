% Create array for CTD data for PRIZE WEST mooring 2017-18

clear all;

addpath C:\MATLAB\seawater
%addpath C:\Code\Matlab\Various
addpath C:\Moorings\PRIZE\PRIZE_18_19\matlab\WEST

mooring_id='WEST_18';
start_date=datenum('22-Jun-2018 12:30:00');
end_date=datenum('25-Nov-2019 05:00:00'); 
waterdepth = 233; %TBC 255 ctd033 228

inst_list = [9382,4196,4197,4198,9395,4199,4200,7294,4201,4216,7295,4218,4220,4302,9396]; 
inst_depth_list = [26,32.5,36.5,46.5,55.5,56.5,66.5,77.5,90.5,97,111,136,161,186,221];
WEST_SBE37_SN = [9382,9395,7294,7295,9396];
WEST_SO_SN = [4196,4197,4198,4199,4200,4201,4216,4218,4220,4302];


% % Read SBE16+ data
% NO SBE16 deployed on 18_19WEST
% fl='WEST17_SBE16_50214.cnv';
% sn = '50214';
% 
% [scan,timeJ,pres,temp,cond,depth,sal,dens,fluo,par,flag]=textread(fl,...
%     '%f%f%f%f%f%f%f%f%f%f%f','headerlines',517);
% 
% % Select in-water data only
% mtime=datenum('31-Dec-2016 00:00:00')+timeJ;
% ind=find(mtime>=start_date & mtime<=end_date);
% 
% % Rename variables
% eval(['time' sn '=mtime(ind);']);
% eval(['pres' sn '=pres(ind);']);
% eval(['temp' sn '=temp(ind);']);
% eval(['cond' sn '=cond(ind);']);
% eval(['depth' sn '=depth(ind);']);
% eval(['sal' sn '=sal(ind);']);
% eval(['dens' sn '=dens(ind);']);
% eval(['fluo' sn '=fluo(ind);']);
% eval(['par' sn '=par(ind);']);
% 
% clear scan timeJ pres temp cond depth sal dens fluo par flag mtime ind sn fl

%% Read SBE37 data

for j=1:length(WEST_SBE37_SN)
    
    sn = num2str(WEST_SBE37_SN(j));
    fl = ['WEST18_SBE37_' sn '.cnv'];
    
    [scan,timeJ,pres,temp,cond,depth,sal,dens,flag]=textread(fl,...
        '%f%f%f%f%f%f%f%f%f','headerlines',300);
    
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
    
end;


%% Read Star-Odi

for j=1:length(WEST_SO_SN)
    
    sn = num2str(WEST_SO_SN(j));
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
%eval(['save(''' mooring_id '_v2.mat'');']);

%v2 is with SO at 56.5m removed (not needed for grid)
