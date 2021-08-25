% Quick plots of PRIZE 2017-18 moorings data
% ESDU, Sep 18
% Edited by Lewis Feb 21

clear; close all;

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

% for k = 1:length(temp_all)
%     interp_temp(:,k) = interp1(inst_depth_list,temp_all(:,k),interp_depth);
% end


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

% % Initialise global temp array
% interp_sal = nan(length(interp_depth),length(interp_time));
% 
% % Finds SBE depths
% for l = 1:length(WEST_SBE_SN)
%     sbe_ind(l) = find(inst_list==WEST_SBE_SN(l));
% end
% inst_depth_list_sbe = inst_depth_list(sbe_ind);
% 
% for k = 1:length(sal_all)
%     interp_sal(:,k) = interp1(inst_depth_list_sbe,sal_all(:,k),interp_depth);
% end
% 
% % Tidy up and save data
% clear ind j k l maxt mint p sal_all temp_all sbe_ind sn wd
eval(['save(''' mooring_id '_18_19.mat'');']);

clear
