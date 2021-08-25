clear all; close('all');
%% EAST
load('C:\Users\SA01LD\Desktop\PRIZE_18_19\data\moor_processed/EAST_17.mat')
T=round(prize_east_17_gridded.temp(:,3:end),2);
S=round(prize_east_17_gridded.sal(:,3:end),2);
P=round(prize_east_17_gridded.pres(:,3:end),2);
dates=cellstr(datestr(prize_east_17_gridded.time_grid(3:end),31))';
lend=length(dates);

fid=fopen('C:\Users\SA01LD\Desktop\PRIZE_18_19\data/ArcticPRIZE_Temperature_east_2017_2018.csv','w');
fprintf(fid,[repmat('%s,',1,lend-1) '%s\r\n'],dates{:});
[nrows,ncols] = size(T);
for row = 1:nrows
    fprintf(fid,[repmat('%4.2f,',1,lend-1) '%4.2f\r\n'],T(row,:));
end
fclose(fid);

fid=fopen('C:\Users\SA01LD\Desktop\PRIZE_18_19\data/ArcticPRIZE_Salinity_east_2017_2018.csv','w');
fprintf(fid,[repmat('%s,',1,lend-1) '%s\r\n'],dates{:});
[nrows,ncols] = size(S);
for row = 1:nrows
    fprintf(fid,[repmat('%4.2f,',1,lend-1) '%4.2f\r\n'],S(row,:));
end
fclose(fid);

fid=fopen('C:\Users\SA01LD\Desktop\PRIZE_18_19\data/ArcticPRIZE_Pressure_east_2017_2018.csv','w');
fprintf(fid,[repmat('%s,',1,lend-1) '%s\r\n'],dates{:});
[nrows,ncols] = size(P);
for row = 1:nrows
    fprintf(fid,[repmat('%4.2f,',1,lend-1) '%4.2f\r\n'],P(row,:));
end
fclose(fid);

%% WEST
load('C:\Users\SA01LD\Desktop\PRIZE_18_19\data\moor_processed/WEST_17.mat')
T=round(prize_west_17_gridded.temp(:,3:end),2);
S=round(prize_west_17_gridded.sal(:,3:end),2);
P=round(prize_west_17_gridded.pres(:,3:end),2);
dates=cellstr(datestr(prize_west_17_gridded.time_grid(3:end),31))';
lend=length(dates);

fid=fopen('C:\Users\SA01LD\Desktop\PRIZE_18_19\data/ArcticPRIZE_Temperature_west_2017_2018.csv','w');
fprintf(fid,[repmat('%s,',1,lend-1) '%s\r\n'],dates{:});
[nrows,ncols] = size(T);
for row = 1:nrows
    fprintf(fid,[repmat('%4.2f,',1,lend-1) '%4.2f\r\n'],T(row,:));
end
fclose(fid);

fid=fopen('C:\Users\SA01LD\Desktop\PRIZE_18_19\data/ArcticPRIZE_Salinity_west_2017_2018.csv','w');
fprintf(fid,[repmat('%s,',1,lend-1) '%s\r\n'],dates{:});
[nrows,ncols] = size(S);
for row = 1:nrows
    fprintf(fid,[repmat('%4.2f,',1,lend-1) '%4.2f\r\n'],S(row,:));
end
fclose(fid);

fid=fopen('C:\Users\SA01LD\Desktop\PRIZE_18_19\data/ArcticPRIZE_Pressure_west_2017_2018.csv','w');
fprintf(fid,[repmat('%s,',1,lend-1) '%s\r\n'],dates{:});
[nrows,ncols] = size(P);
for row = 1:nrows
    fprintf(fid,[repmat('%4.2f,',1,lend-1) '%4.2f\r\n'],P(row,:));
end
fclose(fid);


%% WEST
load('C:\Users\SA01LD\Desktop\PRIZE_18_19\data\moor_processed/WEST_18.mat')
T=round(prize_west_18_gridded.temp(:,3:end),2);
S=round(prize_west_18_gridded.sal(:,3:end),2);
P=round(prize_west_18_gridded.pres(:,3:end),2);
dates=cellstr(datestr(prize_west_18_gridded.time_grid(3:end),31))';
lend=length(dates);

fid=fopen('C:\Users\SA01LD\Desktop\PRIZE_18_19\data/ArcticPRIZE_Temperature_west_2018_2019.csv','w');
fprintf(fid,[repmat('%s,',1,lend-1) '%s\r\n'],dates{:});
[nrows,ncols] = size(T);
for row = 1:nrows
    fprintf(fid,[repmat('%4.2f,',1,lend-1) '%4.2f\r\n'],T(row,:));
end
fclose(fid);

fid=fopen('C:\Users\SA01LD\Desktop\PRIZE_18_19\data/ArcticPRIZE_Salinity_west_2018_2019.csv','w');
fprintf(fid,[repmat('%s,',1,lend-1) '%s\r\n'],dates{:});
[nrows,ncols] = size(S);
for row = 1:nrows
    fprintf(fid,[repmat('%4.2f,',1,lend-1) '%4.2f\r\n'],S(row,:));
end
fclose(fid);

fid=fopen('C:\Users\SA01LD\Desktop\PRIZE_18_19\data/ArcticPRIZE_Pressure_west_2018_2019.csv','w');
fprintf(fid,[repmat('%s,',1,lend-1) '%s\r\n'],dates{:});
[nrows,ncols] = size(P);
for row = 1:nrows
    fprintf(fid,[repmat('%4.2f,',1,lend-1) '%4.2f\r\n'],P(row,:));
end
fclose(fid);

%% EAST
load('C:\Users\SA01LD\Desktop\PRIZE_18_19\data\moor_processed/EAST_18.mat')
T=round(prize_east_18_gridded.temp(:,3:end),2);
S=round(prize_east_18_gridded.sal(:,3:end),2);
P=round(prize_east_18_gridded.pres(:,3:end),2);
dates=cellstr(datestr(prize_east_18_gridded.time_grid(3:end),31))';
lend=length(dates);

fid=fopen('C:\Users\SA01LD\Desktop\PRIZE_18_19\data/ArcticPRIZE_Temperature_east_2018_2019.csv','w');
fprintf(fid,[repmat('%s,',1,lend-1) '%s\r\n'],dates{:});
[nrows,ncols] = size(T);
for row = 1:nrows
    fprintf(fid,[repmat('%4.2f,',1,lend-1) '%4.2f\r\n'],T(row,:));
end
fclose(fid);

fid=fopen('C:\Users\SA01LD\Desktop\PRIZE_18_19\data/ArcticPRIZE_Salinity_east_2018_2019.csv','w');
fprintf(fid,[repmat('%s,',1,lend-1) '%s\r\n'],dates{:});
[nrows,ncols] = size(S);
for row = 1:nrows
    fprintf(fid,[repmat('%4.2f,',1,lend-1) '%4.2f\r\n'],S(row,:));
end
fclose(fid);

fid=fopen('C:\Users\SA01LD\Desktop\PRIZE_18_19\data/ArcticPRIZE_Pressure_east_2018_2019.csv','w');
fprintf(fid,[repmat('%s,',1,lend-1) '%s\r\n'],dates{:});
[nrows,ncols] = size(P);
for row = 1:nrows
    fprintf(fid,[repmat('%4.2f,',1,lend-1) '%4.2f\r\n'],P(row,:));
end
fclose(fid);
