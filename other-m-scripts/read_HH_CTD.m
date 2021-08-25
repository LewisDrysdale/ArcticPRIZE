clearvars; close('all');

indir='C:\Users\sa01ld\OneDrive - SAMS\PRIZE\Ivan-PRIZE-data\HH_Apr_2018\CTD_raw';
outdir='C:\Users\sa01ld\OneDrive - SAMS\PRIZE\Ivan-PRIZE-data\HH_Apr_2018\CTD_processed';

fls=dir([indir filesep '*bin.cnv']);

for ii=1:numel(fls)
    
    fl=[indir filesep fls(ii).name];
    
    [scan,Depth,Pressure,Temperature,Cond,PSAL,Density, SV,...
        Fluor,Turb,nBtl,lat,lon,JDay,Oxy,oxsat,PAR,logPAR,depSM,ptemp,...
        sal00,sigT,svCM,oxysat,flag]=textread(fl,...
     repmat('%f',1,25),'headerlines',297);

    varstrings= ["scan","Depth","Pressure","Temperature","Cond","PSAL","Density", "SV",...
        "Fluor","Turb","nBtl","lat","lon","JDay","Oxy","oxsat","PAR","logPAR","depSM","ptemp",...
        "sal00","sigT","svCM","oxysat","flag"];
    
    vars=[scan,Depth,Pressure,Temperature,Cond,PSAL,Density, SV,...
        Fluor,Turb,nBtl,lat,lon,JDay,Oxy,oxsat,PAR,logPAR,depSM,ptemp,...
        sal00,sigT,svCM,oxysat,flag];
    
    % write to CSV
     outfile = regexprep(fls(ii).name,'_bin.cnv','_1db.csv');
     outfile = [outdir filesep outfile];
     
     fid_out=fopen(outfile,'w');  
     
     % Write header
     fprintf(fid_out,[repmat('%s,',1,24) '%s\r\n'], varstrings);
     
     fclose(fid_out);
     
     % Write data
     dlmwrite(outfile,vars,'delimiter',',','precision','%.4f','-append');
    
     clear outfile vars varstrings
      
end