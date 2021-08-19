%% Create data product for PRIZE mooring
% _*Authors: Emily Venables and Estelle Dumont, 2019; Lewis Drysdale, 2020*_ 

clear; close('all');
%% Set dirs and mooring ID

outdir  =('M:\Mar_Phys\Moorings\PRIZE moorings\PRIZE_18_19\DATA\moor_processed');
indir   =('M:\Mar_Phys\Moorings\PRIZE moorings\PRIZE_18_19\DATA\moor_raw'); 
mooring_id='WEST_17';
count=0;
%% Read data

switch mooring_id  
% Eastern array 2017-2018

    case ('EAST_17')        
    % set mooring parameters here
    start_date=datenum('21-Sep-2017 12:30:00');
    end_date=datenum('17-Jun-2018 05:00:00'); 
    waterdepth = 233; %TBC 255 ctd033 228
    inst_list = [50215,9381,4203,4205,4206,4207,4208,9382,4209,4210,9388,4211,4213,4302,9389];
    inst_depth_list = [21,22,27,31,41,51,61,75,83,96,110,125,140,155,170];
    EAST_SBE16_SN = [50215];
    EAST_SBE37_SN = [9381,9382,9388,9389];
    EAST_SO_SN = [4203,4205,4206,4207,4208,4209,4210,4211,4213,4302];
       
    for j=1:length(inst_list)
        if ismember(inst_list(j),EAST_SBE37_SN)
           fl = [indir filesep '2017/east' filesep 'SBE37SM-RS232_0370' num2str(inst_list(j)) '_2018_06_17postcal.cnv'];
            if ~exist(fl,'file')
                disp(['WARNING: file for instrument ' num2str(inst_list(j)) ' not found!!'])
            else
                count=count+1;
                [timeJ,pres,temp,cond,depth,sal,sv,dens,flag]=textread(fl,...
                '%f%f%f%f%f%f%f%f%f','headerlines',300);
                % Select in-water data only
                mtime=datenum('31-Dec-2016 00:00:00')+timeJ;
                ind=find(mtime>=start_date & mtime<=end_date);
                sz=size(temp);
                if sz(2)==1; temp=temp'; sal=sal'; pres=pres'; dens=dens'; cond=cond'; end

                prize_east_17(count).inst='SBE-37';
                prize_east_17(count).sn=inst_list(j);
                prize_east_17(count).time=mtime(ind);
                prize_east_17(count).pres=pres(ind);
                prize_east_17(count).temp=temp(ind);
                prize_east_17(count).cond=cond(ind);
                prize_east_17(count).sal=sal(ind);
                prize_east_17(count).dens=dens(ind);
                clear scan timeJ pres temp cond depth sal dens flag mtime ind sn fl   
            end
       elseif ismember(inst_list(j),EAST_SBE16_SN) % sbe16
             fl = [indir filesep '2017/east' filesep 'SBE16plus_016' num2str(inst_list(j)) '_2018_06_17.cnv'];
                if ~exist(fl,'file')
                    disp(['WARNING: file for instrment ' num2str(inst_list(j)) ' not found!!'])
                else
                    count=count+1;
                    [pres,timeJ,temp,cond,sal,volt,flag]=textread(fl,...
                                '%f%f%f%f%f%f%f','headerlines',501);
                % Select in-water data only
                mtime=datenum('31-Dec-2016 00:00:00')+timeJ;
                ind=find(mtime>=start_date & mtime<=end_date);
                 sz=size(temp);
                    if sz(2)==1; temp=temp'; sal=sal'; pres=pres'; cond=cond'; end            
                    prize_east_17(count).inst='SBE-16';
                    prize_east_17(count).sn=inst_list(j);
                    prize_east_17(count).time=mtime(ind);
                    prize_east_17(count).pres=pres(ind);
                    prize_east_17(count).temp=temp(ind);
                    prize_east_17(count).cond=cond(ind);
                    prize_east_17(count).sal=sal(ind);
                    clear scan timeJ pres temp cond depth sal dens flag mtime ind sn fl
               end
        else
            sodir = [indir filesep '2017/east'];
            inst=num2str(inst_list(j));
            infile = dir(sprintf(['%s%c*' inst '.dat'],sodir,filesep));
            if isempty(infile)                
                disp(['WARNING: file for instrment ' num2str(inst_list(j)) ' not found!!'])
            else
                count=count+1;
             fl=fullfile(infile.folder, infile.name);
            [scan,datetime,T]=textread(fl,'%f%19c%s','delimiter',' ','headerlines',13);
                for ii=1:numel(T)
                    split_temp=split(T(ii),',');
                    newtempstr=[char(split_temp(1)) '.' char(split_temp(2))];
                    temp(ii)=str2double(newtempstr);
                end
                    sz=size(temp);
                    if sz(2)==1; temp=temp'; end
            
            mtime=datenum(datetime,'dd.mm.yyyy HH:MM:SS');
            ind=find(mtime>=start_date & mtime<=end_date);
            prize_east_17(count).inst='Star-Odi';
            prize_east_17(count).sn=inst_list(j);
            prize_east_17(count).time=mtime(ind);
            prize_east_17(count).temp=temp(ind);
            prize_east_17(count).pres=inst_depth_list(j);
            
            clear scan datetime temp mtime ind sn fl
            end
         end
    end
 
    save([outdir filesep mooring_id '.mat'],'prize_east_17')
 
% Western array 2017-2018

   
    case ('WEST_17')
        
    % set mooring parameters here
    start_date=datenum('23-Sep-2017 12:30:00');
    end_date=datenum('14-Jun-2018 05:00:00'); 
    waterdepth = 233; %TBC 255 ctd033 228
    % REMOVE INSTRUMENT 9386 DUE TO BAD VALUES
    inst_list = [50214,4196,4197,4198,4199,4200,9384,4201,9385,9387,4216,4218,4220];
    inst_depth_list = [21,27,31,41,51,61,88,96,112,162,222,137,187,212];
    WEST_SBE16_SN = [50214];
    WEST_SBE37_SN = [9384,9385,9386,9387];
    WEST_SO_SN = [4196,4197,41981,4199,4200,4201,4215,4216,4218,4220];
    
    for j=1:length(inst_list)
        if ismember(inst_list(j),WEST_SBE37_SN)
           fl = [indir filesep '2017/west' filesep 'SBE37SM-RS232_0370' num2str(inst_list(j)) '_2018_06_14postcal.cnv'];
            [timeJ,pres,temp,cond,depth,sal,sv,dens,flag]=textread(fl,...
                '%f%f%f%f%f%f%f%f%f','headerlines',300);
            % Select in-water data only
            mtime=datenum('31-Dec-2016 00:00:00')+timeJ;
            ind=find(mtime>=start_date & mtime<=end_date);
            sz=size(temp);
            if sz(2)==1; temp=temp'; sal=sal'; pres=pres'; dens=dens'; cond=cond'; end

            prize_west_17(j).inst='SBE-37';
            prize_west_17(j).sn=inst_list(j);
            prize_west_17(j).time=mtime(ind);
            prize_west_17(j).pres=pres(ind);
            prize_west_17(j).temp=temp(ind);
            prize_west_17(j).cond=cond(ind);
            prize_west_17(j).sal=sal(ind);
            prize_west_17(j).dens=dens(ind);
            clear scan timeJ pres temp cond depth sal dens flag mtime ind sn fl   
        elseif ismember(inst_list(j),WEST_SBE16_SN) % sbe16
             fl = [indir filesep '2017/west' filesep 'SBE16plus_016' num2str(inst_list(j)) '_2018_06_15.cnv'];
            [pres,timeJ,temp,cond,sal,volt,flag]=textread(fl,...
                 '%f%f%f%f%f%f%f','headerlines',501);
            % Select in-water data only
            mtime=datenum('31-Dec-2016 00:00:00')+timeJ;
            ind=find(mtime>=start_date & mtime<=end_date);
             sz=size(temp);
            if sz(2)==1; temp=temp'; sal=sal'; pres=pres'; cond=cond'; end            
            prize_west_17(j).inst='SBE-16';
            prize_west_17(j).sn=inst_list(j);
            prize_west_17(j).time=mtime(ind);
            prize_west_17(j).pres=pres(ind);
            prize_west_17(j).temp=temp(ind);
            prize_west_17(j).cond=cond(ind);
            prize_west_17(j).sal=sal(ind);
            clear scan timeJ pres temp cond depth sal dens flag mtime ind sn fl
        else
            fl = [indir filesep '2017/west' filesep '3T' num2str(inst_list(j)) '.DAT'];
            [scan,datetime,T]=textread(fl,'%f%19c%s','delimiter',' ','headerlines',13);
            for ii=1:numel(T)
                split_temp=split(T(ii),',');
                newtempstr=[char(split_temp(1)) '.' char(split_temp(2))];
                temp(ii)=str2double(newtempstr);
            end
            sz=size(temp);
         if sz(2)==1; temp=temp'; end
            
            mtime=datenum(datetime,'dd.mm.yyyy HH:MM:SS');
            ind=find(mtime>=start_date & mtime<=end_date);
            prize_west_17(j).inst='Star-Odi';
            prize_west_17(j).sn=inst_list(j);
            prize_west_17(j).time=mtime(ind);
            prize_west_17(j).temp=temp(ind);
            prize_west_17(j).pres=inst_depth_list(j);
            
            clear scan datetime temp mtime ind sn fl
         end
    end

    save([outdir filesep mooring_id '.mat'],'prize_west_17')
% Western array 2018-2019

    
    case ('WEST_18')
    % set mooring parameters here
    start_date=datenum('22-Jun-2018 12:30:00');
    end_date=datenum('25-Nov-2019 05:00:00'); 
    waterdepth = 233; %TBC 255 ctd033 228
    inst_list = [9382,4196,4197,4198,9395,4199,4200,7294,4201,4216,7295,4218,4220,4302,9396];
    inst_depth_list = [26,32.5,36.5,46.5,55.5,56.5,66.5,77.5,90.5,97,111,136,161,186,221];
    WEST_SBE37_SN = [9382,9395,7294,7295,9396];
    WEST_SO_SN = [4196,4197,4198,4199,4200,4201,4216,4218,4220,4302];
    
    for j=1:length(inst_list)

    
    if ismember(inst_list(j),WEST_SBE37_SN)
                    fl = [indir filesep '2018' filesep 'WEST18_SBE37_' num2str(inst_list(j)) '.cnv'];
            [scan,timeJ,pres,temp,cond,depth,sal,dens,flag]=textread(fl,...
                '%f%f%f%f%f%f%f%f%f','headerlines',300);
            % Select in-water data only
            mtime=datenum('31-Dec-2017 00:00:00')+timeJ;
            ind=find(mtime>=start_date & mtime<=end_date);
            sz=size(temp);
           if sz(2)==1; temp=temp'; sal=sal'; pres=pres'; dens=dens';
                cond=cond'; end 
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
              sz=size(temp);
           if sz(2)==1; temp=temp'; end 
            prize_west_18(j).inst='Star-Odi';
            prize_west_18(j).sn=inst_list(j);
            prize_west_18(j).time=mtime(ind);
            prize_west_18(j).temp=temp(ind);
            prize_west_18(j).pres=inst_depth_list(j);
            
            clear scan datetime temp mtime ind sn fl
         end
    end

    save([outdir filesep mooring_id '.mat'],'prize_west_18')
% Eastern array 2018-2019

    
    case ('EAST_18') % EAST 2018 data
     
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
    for j=1:length(inst_list)
         if ismember(inst_list(j),EAST_SBE37_SN) % SBE 37
            fl = [indir filesep '2018' filesep 'EAST18_SBE37_' num2str(inst_list(j)) '.cnv'];
            [~,timeJ,pres,temp,cond,depth,sal,dens,flag]=textread(fl,...
                '%f%f%f%f%f%f%f%f%f','headerlines',293);
            % Select in-water data only
            mtime=datenum('31-Dec-2017 00:00:00')+timeJ;
            ind=find(mtime>=start_date & mtime<=end_date);
              sz=size(temp);
           if sz(2)==1; temp=temp'; sal=sal'; pres=pres'; dens=dens'; cond=cond'; end 
            prize_east_18(j).inst='SBE-37';
            prize_east_18(j).sn=inst_list(j);
            prize_east_18(j).time=mtime(ind);
            prize_east_18(j).pres=pres(ind);
            prize_east_18(j).temp=temp(ind);
            prize_east_18(j).cond=cond(ind);
            prize_east_18(j).sal=sal(ind);
            prize_east_18(j).dens=dens(ind);
            clear scan timeJ pres temp cond depth sal dens flag mtime ind sn fl
             sz=size(temp);
         elseif ismember(inst_list(j),EAST_SBE_SN) % sbe16
             fl = [indir filesep '2018' filesep 'EAST18_SBE16_' num2str(inst_list(j)) '.txt'];
            [~,timeJ,pres,temp,cond,depth,sal,dens,fluo,par,flag]=textread(fl,...
                 '%f%f%f%f%f%f%f%f%f%f%f','headerlines',20);
             % Select in-water data only
            mtime=datenum('31-Dec-2017 00:00:00')+timeJ;
            ind=find(mtime>=start_date & mtime<=end_date);
            if sz(2)==1; temp=temp'; sal=sal'; pres=pres'; dens=dens';
                fluo=fluo'; par=par'; cond=cond'; end 
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
             sz=size(temp);
         else % STAR-ODI
            fl = [indir filesep  '2018' filesep 'T' num2str(inst_list(j)) '.DAT'];
            [~,datetime,temp]=textread(fl,'%f%19c%f','delimiter',' ','headerlines',12);
            mtime=datenum(datetime,'dd.mm.yyyy HH:MM:SS');  
            ind=find(mtime>=start_date & mtime<=end_date);
            if sz(2)==1; temp=temp';  end
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

% Check plots

if strcmpi(mooring_id,'WEST_17')==1
    data=prize_west_17;
elseif strcmpi(mooring_id,'EAST_17')==1
    data=prize_east_17;
elseif strcmpi(mooring_id,'WEST_18')==1
    data=prize_west_18;
elseif strcmpi(mooring_id,'EAST_18')==1
    data=prize_east_18;
else
    disp('No data to plot!')
end