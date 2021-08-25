%% Read KPH CTD data

%% based on CNVread written by Jo Hopkins

clear all
inpath='C:\Moorings\PRIZE\PRIZE_18_19\DATA\CTD\KPH\';
filename='Sta0338.cnv';
driver='C:\Moorings\PRIZE\PRIZE_18_19\DATA\CTD\KPH\KPH2019_CTDcnv_1db_driver.csv';
outpath=inpath;
cast=338;

%% Read in driver file containing file contents
    fid=fopen(driver);
        H = textscan(fid,'%s%s','delimiter',',');
    fclose(fid);

    
% Transpose
    H=cellfun(@transpose,H,'UniformOutput',false);
    %headers = cell2table([H{1}; H{2}])
    
%% Loop through input file and extract columns of data
infile = [inpath filename];
fid = fopen(infile,'r');            %open input file for reading

while 1  % Read each line of the input file                       
    lines = fgetl(fid);
    
% check for blank delimiter line at end of file    
    if ~isstr(lines);break;end    
    % loop through file header until '*END*' is reached.
% skip out of loop to start reading data
    if strncmp(lines,'*END*',5);     
        break                        
    end
    
end

row = 0;
while 1             
    lines = fgetl(fid);              %Read each line of the input file
    if ~isstr(lines);break;end        %check for blank delimiter line at end of file
    row = row+1;                      %increment line counter
    DATA(row,:) = sscanf(lines,'%f')';   %read into output variable.
end

fclose(fid);

%%apply variables
vars=char(H{1});
for ind = 1:size(DATA,2)
    eval(['S.' strtrim(vars(ind,:)) '=DATA(:,' num2str(ind) ');']);
end

S.vars=char(H{1});
S.units=char(H{2});
S.CAST=cast;

% Rename structure
sname = 'CTDkph';
sname(end-(size(num2str(cast),2)-1):end) = num2str(cast);
eval([sname,' = S;',])

% Save
outfile = filename(1:end-4);
eval(['save ',outpath outfile ,' ',sname])