% Quick plots of PRIZE 2018-19 moorings data
% ESDU, Sep 18

clear; close all;
addpath C:\Matlab\various

%% Setup
% Load data
EAST=load('EAST_18.mat');
WEST=load('WEST_18.mat');

% Set plot limits
tlim = [-2 6.5];
slim = [32.4 35.5];


%% Plot temp contours
figure('units','normalized','outerposition',[0 0 1 1]);

subplot(2,1,1)
imagesc(EAST.interp_time,EAST.interp_depth,EAST.interp_temp)
title ('Temperature EAST 2018-19');
ylabel('Depth (m)');
datetick('x','mmm-yy')
h=colorbar;
colormap('jet')
set(get(h,'xlabel'),'string','^oC')
caxis(tlim)

subplot(2,1,2)
imagesc(WEST.interp_time,WEST.interp_depth,WEST.interp_temp)
title ('Temperature WEST 2018-19');
ylabel('Depth (m)');
datetick('x','mmm-yy')
h=colorbar;
colormap('jet')
set(get(h,'xlabel'),'string','^oC')
caxis(tlim)


%% Plot sal contours
figure('units','normalized','outerposition',[0 0 1 1]);

subplot(2,1,1)
imagesc(EAST.interp_time,EAST.interp_depth,EAST.interp_sal)
title ('Salinity EAST 2018-19');
ylabel('Depth (m)');
datetick('x','mmm-yy')
h=colorbar;
colormap('jet')
set(get(h,'xlabel'),'string','psu')
caxis(slim)

subplot(2,1,2)
imagesc(WEST.interp_time,WEST.interp_depth,WEST.interp_sal)
title ('Salinity WEST 2018-19');
ylabel('Depth (m)');
datetick('x','mmm-yy')
h=colorbar;
colormap('jet')
set(get(h,'xlabel'),'string','psu')
caxis(slim)


%% Plot EAST
figure('units','normalized','outerposition',[0 0 1 1]);

subplot(6,1,3:4)
subplot(2,1,1)
imagesc(EAST.interp_time,EAST.interp_depth,EAST.interp_temp)
title ('Temperature EAST 2018-19');
ylabel('Depth (m)');
datetick('x','mmm-yy')
h=colorbar;
colormap('jet')
set(get(h,'xlabel'),'string','^oC')
caxis(tlim)

subplot(6,1,5:6)
subplot(2,1,2)
imagesc(EAST.interp_time,EAST.interp_depth,EAST.interp_sal)
title ('Salinity EAST 2018-19');
ylabel('Depth (m)');
datetick('x','mmm-yy')
h=colorbar;
colormap('jet')
set(get(h,'xlabel'),'string','psu')
caxis(slim)


%% Plot WEST
figure('units','normalized','outerposition',[0 0 1 1]);

% p1=subplot(6,1,1);
% plot(WEST.time50214,WEST.fluo50214,'color',rgb('ForestGreen'))
% title ('Fluorescence @ 21m WEST 2018-19');
% ylabel('Fluo (mg/m^3)');
% datetick('x','mmm-yy')
% ylim([-0.1 20])
% grid on
% 
% p2=subplot(6,1,2);
% plot(WEST.time50214,WEST.par50214,'color',rgb('Goldenrod'))
% title ('PAR @ 21m WEST 2018-19');
% ylabel('PAR (\mumol photons/m^2/s)');
% datetick('x','mmm-yy')
% grid on

p3 = subplot(6,1,3:4);
subplot(2,1,1)
imagesc(WEST.interp_time,WEST.interp_depth,WEST.interp_temp)
ylabel('Depth (m)');
title ('Temperature WEST 2018-19');
datetick('x','mmm-yy')
h=colorbar;
colormap('jet')
set(get(h,'xlabel'),'string','^oC')
caxis(tlim)

p4 = subplot(6,1,5:6);
subplot(2,1,2)
imagesc(WEST.interp_time,WEST.interp_depth,WEST.interp_sal)
%imagesc(WEST.interp_time,WEST.interp_depth,WEST.interp_sal_v2)
hold on
% for k = 1:length(WEST.inst_depth_list_sbe)
%     plot([datenum('01-Jun-18'),datenum('30-Nov-19')],[WEST.inst_depth_list_sbe(k),WEST.inst_depth_list_sbe(k)],'--k')
% end
ylabel('Depth (m)');
datetick('x','mmm-yy')
title ('Salinity WEST 2018-19');
h=colorbar;
colormap('jet')
set(get(h,'xlabel'),'string','psu');
caxis(slim)

% % Align plots
% psize=get(p3,'position');
% psize1=get(p1,'position');
% set(p1,'position',[psize1(1) psize1(2) psize(3) psize1(4)]);
% psize2=get(p2,'position');
% set(p2,'position',[psize2(1) psize2(2) psize(3) psize2(4)]);

