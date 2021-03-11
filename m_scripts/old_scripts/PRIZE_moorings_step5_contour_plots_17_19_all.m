% Quick plots of PRIZE 2018-19 moorings data
% ESDU, Sep 18

clear; close all;
%addpath C:\Code\Matlab\Various

%% Setup
% Load data
EAST17=load('C:\Moorings\PRIZE\PRIZE_18_19\matlab\EAST_17.mat');
WEST17=load('C:\Moorings\PRIZE\PRIZE_18_19\matlab\WEST_17.mat');
EAST18=load('C:\Moorings\PRIZE\PRIZE_18_19\matlab\EAST_18.mat');
WEST18=load('C:\Moorings\PRIZE\PRIZE_18_19\matlab\WEST_18.mat');

% Set plot limits
tlim = [-2 6.5];
slim = [32.8 35.2];


%% Plot temp contours
figure('units','normalized','outerposition',[0 0 1 1]);

pt1 = subplot(2,1,1);
hold on
imagesc(EAST17.interp_time,EAST17.interp_depth,EAST17.interp_temp)
imagesc(EAST18.interp_time,EAST18.interp_depth,EAST18.interp_temp)
title ('Temperature EAST');
set(gca,'YDir','reverse')
ylabel('Depth (m)');
set(gca,'xtick',[datenum('01-Sep-17'):91.5:datenum('04-Dec-19')])
datetick('x','mmm-yy','keepticks')
h=colorbar;
ct = colormap(cmocean('balance'));
set(get(h,'xlabel'),'string','^oC')
caxis(tlim)
ct(1,1)=1; ct(1,2)=1; ct(1,3)=1; colormap(ct);

pt2 = subplot(2,1,2);
hold on
imagesc(WEST17.interp_time,WEST17.interp_depth,WEST17.interp_temp)
imagesc(WEST18.interp_time,WEST18.interp_depth,WEST18.interp_temp)
title ('Temperature WEST');
set(gca,'YDir','reverse')
ylabel('Depth (m)');
set(gca,'xtick',[datenum('01-Sep-17'):91.5:datenum('04-Dec-19')])
datetick('x','mmm-yy','keepticks')
h=colorbar;
colormap(ct);
set(get(h,'xlabel'),'string','^oC')
caxis(tlim)

linkaxes([pt1 pt2],'xy')
set(gca,'Ylim',[0 230])

subplot(2,1,1)
plot([datenum('01-Sep-17') datenum('04-Dec-19')],[0 0],'k-')
plot([datenum('03-Dec-19') datenum('03-Dec-19')],[0 230],'k-')
subplot(2,1,2)
plot([datenum('01-Sep-17') datenum('04-Dec-19')],[0 0],'k-')
plot([datenum('01-Sep-17') datenum('04-Dec-19')],[230 230],'k-')
plot([datenum('03-Dec-19') datenum('03-Dec-19')],[0 230],'k-')


%% Plot sal contours

figure('units','normalized','outerposition',[0 0 1 1]);

ps1 = subplot(2,1,1);
hold on
imagesc(EAST17.interp_time,EAST17.interp_depth,EAST17.interp_sal)
imagesc(EAST18.interp_time,EAST18.interp_depth,EAST18.interp_sal)
title ('Salinity EAST');
set(gca,'YDir','reverse')
ylabel('Depth (m)');
set(gca,'xtick',[datenum('01-Sep-17'):91.5:datenum('04-Dec-19')])
datetick('x','mmm-yy','keepticks')
hs=colorbar;
cs = colormap('jet');
set(get(hs,'xlabel'),'string','psu')
caxis(slim)
cs(1,1)=1; cs(1,2)=1; cs(1,3)=1; colormap(cs);

ps2 = subplot(2,1,2);
hold on
imagesc(WEST17.interp_time,WEST17.interp_depth,WEST17.interp_sal_v2)
imagesc(WEST18.interp_time,WEST18.interp_depth,WEST18.interp_sal)
title ('Salinity WEST');
set(gca,'YDir','reverse')
ylabel('Depth (m)');
set(gca,'xtick',[datenum('01-Sep-17'):91.5:datenum('04-Dec-19')])
datetick('x','mmm-yy','keepticks')
hs=colorbar;
colormap(cs);
set(get(hs,'xlabel'),'string','psu')
caxis(slim)

linkaxes([ps1 ps2],'xy')
set(gca,'Ylim',[0 230])

subplot(2,1,1)
plot([datenum('01-Sep-17') datenum('04-Dec-19')],[0 0],'k-')
plot([datenum('03-Dec-19') datenum('03-Dec-19')],[0 230],'k-')
subplot(2,1,2)
plot([datenum('01-Sep-17') datenum('04-Dec-19')],[0 0],'k-')
plot([datenum('01-Sep-17') datenum('04-Dec-19')],[230 230],'k-')
plot([datenum('03-Dec-19') datenum('03-Dec-19')],[0 230],'k-')


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

