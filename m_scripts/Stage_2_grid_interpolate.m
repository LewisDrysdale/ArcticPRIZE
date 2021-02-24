% GRID MOORING DATA FROM PRIZE
clear; close all;

%% set directories and gridding parameters
data_dir = 'C:\Users\sa01ld\Desktop\PRIZE_18_19\data\moor_processed'
plot_dir = 'C:\Users\sa01ld\Desktop\PRIZE_18_19\plots';
% data are sampled at 2 hour intervals, SBE16, 6 min, Star-Odi, 12 mins,
% SBE 37
%% SET PARAMS FOR GRIDDING AND FILTERING
t_interp    = 1/2; % every 6 hours
z_interp     = 10;   % every 2 metres
y_tol       = [-10 10];    % deviation in PSU allowed by depsike routine
stddy_tol    = 4;           % tolerance range of differences between adjacent values of y
nloop        = 5;           % despike loop number

%% GRID WEST 17
mooring='WEST_17';

start_date  = datenum('23-Sep-2017');
end_date    = datenum('14-Jun-2018');

% make dir in plot folder
if ~exist([plot_dir filesep mooring],'dir')==1
    mkdir([plot_dir filesep mooring])
end

% load data structure
load([data_dir filesep mooring '.mat']);

[prize_west_17_gridded]=prize_grid_linear_interp(prize_west_17,plot_dir,mooring,t_interp,z_interp,start_date,end_date,y_tol,stddy_tol,nloop)
% SAVE data structure
save([data_dir filesep mooring '.mat'],'prize_west_17_gridded','prize_west_18');

%% GRID EAST
% mooring='EAST_18';
% start_date  = datenum('21-June-2018');
% end_date    = datenum('17-Nov-2019');
% % make dir in plot folder
% if ~exist([plot_dir filesep mooring],'dir')==1
%     mkdir([plot_dir filesep mooring])
% end
% 
% % load data structure
% load([data_dir filesep mooring '.mat']);
% 
% [prize_east_18_gridded]=prize_grid_linear_interp(prize_east_18,plot_dir,mooring,t_interp,z_interp,start_date,end_date,y_tol,stddy_tol,nloop)
% % SAVE data structure
% save([data_dir filesep mooring '.mat'],'prize_east_18_gridded','prize_east_18');

%% GRID WEST 18
% mooring='WEST_18';
% 
% start_date  = datenum('21-June-2018');
% end_date    = datenum('17-Nov-2019');
% 
% % make dir in plot folder
% if ~exist([plot_dir filesep mooring],'dir')==1
%     mkdir([plot_dir filesep mooring])
% end
% 
% % load data structure
% load([data_dir filesep mooring '.mat']);
% 
% [prize_west_18_gridded]=prize_grid_linear_interp(prize_west_18,plot_dir,mooring,t_interp,z_interp,start_date,end_date,y_tol,stddy_tol,nloop)
% % SAVE data structure
% save([data_dir filesep mooring '.mat'],'prize_west_18_gridded','prize_west_18');
