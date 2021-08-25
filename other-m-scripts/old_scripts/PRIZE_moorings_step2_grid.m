% Quick plots of PRIZE 2017-18 moorings data
% ESDU, Sep 18
% edited by Lewis, FEB 2021

clear; close all;

%% set directories and gridding parameters
data_dir = 'C:\Users\sa01ld\Desktop\PRIZE_18_19\data\moor_processed'
plot_dir = 'C:\Users\sa01ld\Desktop\PRIZE_18_19\plots';
% data are sampled at 2 hour intervals, SBE16, 6 min, Star-Odi, 12 mins,
% SBE 37

%% GRID EAST
%% SET PARAMS FOR GRIDDING AND FILTERING
t_interp    = 1/2; % every 6 hours
z_iterp     = 2;   % every 2 metres
start_date  = datenum('21-June-2018');
end_date    = datenum('17-Nov-2019');
t_grid = start_date:t_interp:end_date;
y_tol       = [-10 10];    % deviation in PSU allowed by depsike routine
stddy_tol    = 4;           % tolerance range of differences between adjacent values of y
nloop        = 5;           % despike loop number

%% interpolate on to time grid
% initialise empty arrays for grid
T=[];S=[];PRES_T=[];PRES_S=[];

% load data structure
load([data_dir filesep 'EAST_18.mat']);

for ii=1:numel(prize_east_18)
    
    % extract data to workspace variables
    temp    =prize_east_18(ii).temp;
    sal     =prize_east_18(ii).sal;
    pres    =prize_east_18(ii).pres;
    time    =prize_east_18(ii).time;
    
    %   Try despike salinity, replace bad values with NAN - SBE only!
    if ~isempty(sal)    
        [sal,dx,~] = ddspike(sal,y_tol,stddy_tol,[nloop],'y',NaN);
        
        % Replace contemperaneous temperatures with NAN
        temp(dx)         = NaN;
        
        % save de-spike plots
        ylabel('Salinity');
        title(['intrument sn ' num2str(prize_east_18(ii).sn)]);
        savename=[plot_dir filesep 'east_18/despike_instrumentsn ' num2str(prize_east_18(ii).sn)];
        print(gcf,'-dpng',savename);       
        
        % interpolate salinity data
        S=[S;interp1(time, sal, t_grid)];
        PRES_S=[PRES_S;interp1(time, pres, t_grid)];
    else
        % Star-Odi data, has tempertaure only
        % interpolate temp, no despike
        T=[T;interp1(time, temp, t_grid)];
        PRES_T=[PRES_T; repmat(pres,1,numel(t_grid))];
    end

end
%% low-pass filter the data

t_res    = diff(t_grid(1:2));   % get temporal resolution of new grid
co       = 1/2;                 % filter cut off frequency [1/days]
fss      = 2;                   % final sub-sampling frequency [1/days]

% filter Temperature
for jj = 1:numel(PRES_T(:,1))
    t_nan = find(~isnan(T(jj,:)));
    p_nan = find(~isnan(PRES_T(jj,:)));
    Tf(jj,t_nan) = auto_filt(T(jj,t_nan),1/t_res,co);    
    % interpolate on to original grid
    Tf(jj,:)     = interp1(t_grid(t_nan),Tf(jj,t_nan)',t_grid)';
end

% filter Salinity
for jj = 1:numel(PRES_S(:,1))
    s_nan = find(~isnan(S(jj,:)));
    p_nan = find(~isnan(PRES_S(jj,:)));
    Sf(jj,s_nan) = auto_filt(S(jj,s_nan),1/t_res,co);    
    % interpolate on to original grid
    Sf(jj,:)     = interp1(t_grid(s_nan),Sf(jj,s_nan)',t_grid)';
end

% Filter pressue
for jj = 1:numel(PRES_S(:,1))
    p_nan = find(~isnan(PRES_S(jj,:)));
    Pfs(jj,p_nan) = auto_filt(PRES_S(jj,p_nan),1/t_res,co);    
    % interpolate on to original grid
    Pfs(jj,:)     = interp1(t_grid(p_nan),Pfs(jj,p_nan)',t_grid)';
end

% no filter neccessary for star-odi data as pressure not sampled
Pf  = PRES_T;
    
% create new time grid
tgd   = start_date+2:1/fss:end_date-2;

% interpolate filtered data on to new grid
Tft      = interp1(t_grid,Tf',tgd)';
Pft      = interp1(t_grid,Pf',tgd)';
Sfs      = interp1(t_grid,Sf',tgd)';
Pfs      = interp1(t_grid,Pfs',tgd)';

%% interpolate on to depth grid
gridsize = 10; % vertical depth grid
pmin     = ceil(mmin(Pfs)/gridsize)*gridsize;
pmax     = floor(mmax(Pfs)/gridsize)*gridsize;
p_grid   = [pmin:gridsize:pmax]';

TGfs = nan(length(p_grid),length(tgd));
SGfs = nan(length(p_grid),length(tgd)); 
for ijj=1:length(tgd)
    SGfs(:,ijj) = interp1(Pfs(:,ijj),Sfs(:,ijj),p_grid) ;        
end


%% plot the data 
clf;figure(1);
ax(1)=subplot(3,1,1)
[c,h]=contourf(S);
axis ij
cmocean('haline')
colorbar
title('Temporally interpolated')

ax(2)=subplot(3,1,2)
[c,h]=contourf(Sfs);
axis ij
cmocean('haline')
colorbar
title('Temporally interpolated and Low pass filtered')

ax(3)=subplot(3,1,3)
[c,h]=contourf(tgd,p_grid,SGfs);
axis ij
datetick('x',12,'keepticks')
cmocean('haline')
colorbar
title('Vertciallly Interpolated and low pass filtered')

%%
% Average data bi-hourly (note: using start and end time ajusted even hours)
binsize_x = 1/12;
interp_time = [start_date:binsize_x:end_date];
% Later on interpolate every 2 meters
binsize_y = 2;
if mod(waterdepth,2)==0 % even number
    wd = waterdepth;
else
    wd = waterdepth+1;
end    
interp_depth = [0:binsize_y:wd];


%% Temperature grid

% Initialise array
temp_all = nan(length(inst_list),length(interp_time));

% Loop through all the instruments
for j=1:length(inst_list)
    
    sn = num2str(inst_list(j));
    eval(['TIME = time' sn ';']);
    eval(['TEMP = temp' sn ';']);
    
    % Average data for each 2-hours period (looking one hour before and one
    % hour after)
    for ind=1:length(interp_time)
        mint = interp_time(ind) - (binsize_x./2);
        maxt = interp_time(ind) + (binsize_x./2);
        p=find(TIME>=mint & TIME<=maxt);
        interptemp(ind)=nanmean(TEMP(p));
        p = [];
    end
    % Save data
    temp_all(j,:)=interptemp;
    
    clear TIME TEMP interptemp
    
end

% Now that all the instruments are all on the same temporal scale grid 
% data in depth

% Initialise global temp array
interp_temp = nan(length(interp_depth),length(interp_time));

for k = 1:length(temp_all)
    interp_temp(:,k) = interp1(inst_depth_list,temp_all(:,k),interp_depth);
end

%% Salinity grid

% Initialise array
sal_all = nan(length(EAST_SBE37_SN),length(interp_time));

% Loop through all the instruments
for j=1:length(EAST_SBE37_SN)
    
    sn = num2str(EAST_SBE37_SN(j));
    eval(['TIME = time' sn ';']);
    eval(['SAL = sal' sn ';']);
    
    % Average data for each 2-hours period (looking one hour before and one
    % hour after)
    for ind=1:length(interp_time)
        mint = interp_time(ind) - (binsize_x./2);
        maxt = interp_time(ind) + (binsize_x./2);
        p=find(TIME>=mint & TIME<=maxt);
        interpsal(ind)=nanmean(SAL(p));
        p = [];
    end
    % Save data
    sal_all(j,:)=interpsal;
    
    clear TIME SAL interpsal
    
end

%%
% Now that all the instruments are all on the same temporal scale grid 
% data in depth

% Initialise global temp array
interp_sal = nan(length(interp_depth),length(interp_time));

% Finds SBE depths
for l = 1:length(EAST_SBE37_SN)
    sbe_ind(l) = find(inst_list==EAST_SBE37_SN(l));
end
inst_depth_list_sbe = inst_depth_list(sbe_ind);

for k = 1:length(sal_all)
    interp_sal(:,k) = interp1(inst_depth_list_sbe,sal_all(:,k),interp_depth);
end

% Tidy up and save data
clear ind j k l maxt mint p sal_all temp_all sbe_ind sn wd
eval(['save(''' mooring_id '.mat'');']);

clear




%% WEST

load('WEST_18.mat');

% Average data bi-hourly (note: using start and end time ajusted even hours)
binsize_x = 1/12;
interp_time = [start_date:binsize_x:end_date];
% Later on interpolate every 2 meters
binsize_y = 2;
if mod(waterdepth,2)==0 % even number
    wd = waterdepth;
else
    wd = waterdepth+1;
end    
interp_depth = [0:binsize_y:wd];


%% Temperature grid

% Initialise array
temp_all = nan(length(inst_list),length(interp_time));

% Loop through all the instruments
for j=1:length(inst_list)
    
    sn = num2str(inst_list(j));
    eval(['TIME = time' sn ';']);
    eval(['TEMP = temp' sn ';']);
    
    % Average data for each 2-hours period (looking one hour before and one
    % hour after)
    for ind=1:length(interp_time)
        mint = interp_time(ind) - (binsize_x./2);
        maxt = interp_time(ind) + (binsize_x./2);
        p=find(TIME>=mint & TIME<=maxt);
        interptemp(ind)=nanmean(TEMP(p));
        p = [];
    end
    % Save data
    temp_all(j,:)=interptemp;
    
    clear TIME TEMP interptemp
    
end

% Now that all the instruments are all on the same temporal scale grid 
% data in depth

% Initialise global temp array
interp_temp = nan(length(interp_depth),length(interp_time));

for k = 1:length(temp_all)
    interp_temp(:,k) = interp1(inst_depth_list,temp_all(:,k),interp_depth);
end


%% Salinity grid

% Add SBE16+ to SBE37 list to be added in grid

WEST_SBE_SN=WEST_SBE37_SN;

% Initialise array
sal_all = nan(length(WEST_SBE_SN),length(interp_time));

% Loop through all the instruments
for j=1:length(WEST_SBE_SN)
    
    sn = num2str(WEST_SBE_SN(j));
    eval(['TIME = time' sn ';']);
    eval(['SAL = sal' sn ';']);
    
    % Average data for each 2-hours period (looking one hour before and one
    % hour after)
    for ind=1:length(interp_time)
        mint = interp_time(ind) - (binsize_x./2);
        maxt = interp_time(ind) + (binsize_x./2);
        p=find(TIME>=mint & TIME<=maxt);
        interpsal(ind)=nanmean(SAL(p));
        p = [];
    end
    % Save data
    sal_all(j,:)=interpsal;
    
    clear TIME SAL interpsal
    
end

% Now that all the instruments are all on the same temporal scale grid 
% data in depth

% Initialise global temp array
interp_sal = nan(length(interp_depth),length(interp_time));

% Finds SBE depths
for l = 1:length(WEST_SBE_SN)
    sbe_ind(l) = find(inst_list==WEST_SBE_SN(l));
end
inst_depth_list_sbe = inst_depth_list(sbe_ind);

for k = 1:length(sal_all)
    interp_sal(:,k) = interp1(inst_depth_list_sbe,sal_all(:,k),interp_depth);
end

% Tidy up and save data
clear ind j k l maxt mint p sal_all temp_all sbe_ind sn wd
%eval(['save(''' mooring_id '_v2.mat'');']);
eval(['save(''' mooring_id '.mat'');']);
clear
