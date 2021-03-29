data=prize_west_17_gridded.temp(:,3:end);
dates=datestr(prize_west_17_gridded.time_grid(3:end),'dd-mmm-yyyy')';
lend=length(dates);
fileID=fopen('ArcticPRIZE_Temperature_west_2017_2018.txt','w');
fprintf(fileID,[repmat('%s,',1,lend-1) '%s\r\n'],'delimiter',',',dates)

for ii=1:length(m(:,1))
    fprintf(fileID,[repmat('%4.2f,',1,lend-1) '%4.2f\r\n'],'delimiter',',',data(ii,:));
end

fclose(fileID)