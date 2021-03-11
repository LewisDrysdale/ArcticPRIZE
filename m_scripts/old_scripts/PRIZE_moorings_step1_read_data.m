% Create array for CTD data for PRIZE WEST mooring 2017-18
% script written by Emily and Estelle (?) for reading prize mooriong data,
% edited by Lewis
clear; close('all');
%% set dirs
outdir  =('C:\Users\sa01ld\Desktop\PRIZE_18_19\data\moor_processed');
indir   =('C:\Users\sa01ld\Desktop\PRIZE_18_19\data\moor_raw');

%% MOORING PARAMS 
mooring_id='WEST_18';
% mooring_id='EAST_18';
% mooring_id='EAST_19';

if strcmpi(mooring_id,'WEST_18')==1
    % set mooring parameters here
    start_date=datenum('22-Jun-2018 12:30:00');
    end_date=datenum('25-Nov-2019 05:00:00'); 
    waterdepth = 233; %TBC 255 ctd033 228
    inst_list = [9382,4196,4197,4198,9395,4199,4200,7294,4201,4216,7295,4218,4220,4302,9396];
    inst_depth_list = [26,32.5,36.5,46.5,55.5,56.5,66.5,77.5,90.5,97,111,136,161,186,221];
    WEST_SBE37_SN = [9382,9395,7294,7295,9396];
    WEST_SO_SN = [4196,4197,4198,4199,4200,4201,4216,4218,4220,4302];
    
    %% Read data into stucture
    for j=1:length(inst_list)
         if ismember(inst_list(j),WEST_SBE37_SN)
                    fl = [indir filesep '2018' filesep 'WEST18_SBE37_' num2str(inst_list(j)) '.cnv'];
            [scan,timeJ,pres,temp,cond,depth,sal,dens,flag]=textread(fl,...
                '%f%f%f%f%f%f%f%f%f','headerlines',300);
            % Select in-water data only
            mtime=datenum('31-Dec-2017 00:00:00')+timeJ;
            ind=find(mtime>=start_date & mtime<=end_date);

            prize_west_18(j).inst='SBE-37';
            prize_west_18(j).sn=inst_list(j);
            prize_west_18(j).time=mtime(ind);
            prize_west_18(j).pres=pres(ind);
            prize_west_18(j).temp=temp(ind);
            prize_west_18(j).cond=cond(ind);
            prize_west_18(j).sal=sal(ind);
            prize_west_18(j).dens=dens(ind);
            clear scan timeJ pres temp cond depth sal dens flag mtime ind sn fl   
        else
            fl = [indir filesep '2018' filesep 'T' num2str(inst_list(j)) '.DAT'];
            [scan,datetime,temp]=textread(fl,'%f%19c%f','delimiter',' ','headerlines',12);
            mtime=datenum(datetime,'dd.mm.yyyy HH:MM:SS');  
            ind=find(mtime>=start_date & mtime<=end_date);

            prize_west_18(j).inst='Star-Odi';
            prize_west_18(j).sn=inst_list(j);
            prize_west_18(j).time=mtime(ind);
            prize_west_18(j).temp=temp(ind);
            prize_west_18(j).pres=inst_depth_list(j);
            
            clear scan datetime temp mtime ind sn fl
         end
    end

    save([outdir filesep mooring_id '.mat'],'prize_west_18')
    
elseif strcmpi(mooring_id,'EAST_18')
    % EAST 2018 data 
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
    %% Read data into stucture
    for j=1:length(inst_list)
         if ismember(inst_list(j),EAST_SBE37_SN) % SBE 37
            fl = [indir filesep '2018' filesep 'EAST18_SBE37_' num2str(inst_list(j)) '.cnv'];
            [scan,timeJ,pres,temp,cond,depth,sal,dens,flag]=textread(fl,...
                '%f%f%f%f%f%f%f%f%f','headerlines',293);
            % Select in-water data only
            mtime=datenum('31-Dec-2017 00:00:00')+timeJ;
            ind=find(mtime>=start_date & mtime<=end_date);
            prize_east_18(j).inst='SBE-37';
            prize_east_18(j).sn=inst_list(j);
            prize_east_18(j).time=mtime(ind);
            prize_east_18(j).pres=pres(ind);
            prize_east_18(j).temp=temp(ind);
            prize_east_18(j).cond=cond(ind);
            prize_east_18(j).sal=sal(ind);
            prize_east_18(j).dens=dens(ind);
            clear scan timeJ pres temp cond depth sal dens flag mtime ind sn fl
         elseif ismember(inst_list(j),EAST_SBE_SN) % sbe16
             fl = [indir filesep '2018' filesep 'EAST18_SBE16_' num2str(inst_list(j)) '.txt'];
            [scan,timeJ,pres,temp,cond,depth,sal,dens,fluo,par,flag]=textread(fl,...
                 '%f%f%f%f%f%f%f%f%f%f%f','headerlines',20);
             % Select in-water data only
            mtime=datenum('31-Dec-2017 00:00:00')+timeJ;
            ind=find(mtime>=start_date & mtime<=end_date);
            prize_east_18(j).inst='SBE-16';
            prize_east_18(j).sn=inst_list(j);
            prize_east_18(j).time=mtime(ind);
            prize_east_18(j).pres=pres(ind);
            prize_east_18(j).temp=temp(ind);
            prize_east_18(j).cond=cond(ind);
            prize_east_18(j).sal=sal(ind);
            prize_east_18(j).dens=dens(ind);            
            prize_east_18(j).fluo=fluo(ind);
            prize_east_18(j).par=par(ind);
            clear scan timeJ pres temp cond depth sal dens flag mtime ind sn fl
         else % STAR-ODI
            fl = [indir filesep  '2018' filesep 'T' num2str(inst_list(j)) '.DAT'];
            [scan,datetime,temp]=textread(fl,'%f%19c%f','delimiter',' ','headerlines',12);
            mtime=datenum(datetime,'dd.mm.yyyy HH:MM:SS');  
            ind=find(mtime>=start_date & mtime<=end_date);
            prize_east_18(j).inst='Star-Odi';
            prize_east_18(j).sn=inst_list(j);
            prize_east_18(j).time=mtime(ind);
            prize_east_18(j).temp=temp(ind);
            prize_east_18(j).pres=inst_depth_list(j);
            clear scan datetime temp mtime ind sn fl
         end
    end
    save([outdir filesep mooring_id '.mat'],'prize_east_18')
end
