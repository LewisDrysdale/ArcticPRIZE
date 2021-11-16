clear; close('all')

data_dir = 'C:\Users\sa01ld\OneDrive - SAMS\Projects\PRIZE\BODC_submission';

% load west 17
mid='WEST_17';
w17=load([data_dir filesep mid '.mat']);
% load east 18
mid='EAST_18';
e18=load([data_dir filesep mid '.mat']);

figure;
x=datetime(e18.prize_east_18(1).jd,'ConvertFrom','juliandate');
y=e18.prize_east_18(1).fluo;
plot(x,y,'.k')  
hold on

% read CTD fluor from JR17006
data_dir='C:\Users\sa01ld\OneDrive - SAMS\Projects\PRIZE\SBE16-cal\data';
fles=dir([data_dir filesep '*_1db_down.csv']);
for ii=1:numel(fles)
    ctablr=readtable(fullfile(fles(ii).folder,fles(ii).name));
    ix1=ctablr.CTDpres>=20;
    ix2=ctablr.CTDpres<=26;
    id=ix1&ix2;
    
    x=datetime(ctablr.CTDjday(id)+datenum('31-Dec-2017 00:00:00'),'ConvertFrom','datenum');
    x=x(4);
    y=nanmean(ctablr.CTDfluor(id));
    h1=plot(x,y,'ro','LineWidth',4);
end

% read CTD data from KPH
fles=dir([data_dir filesep '*.cnv']);

for ii=1:numel(fles)
    fl=[fles(ii).folder filesep fles(ii).name];
    [Scan,Pressure,Depth,Temperaturet068C,Temperature,Conductivity,...
        Conductivity2,Oxygenraw,Altimeter,Oxygen,Density,SoundVelocity,...
        avSoundVelocity,BeamTransmission,Fluorescence,Voltage,...
        Oxygensbe43,Salinity,Salinity2,Density2,SoundVelocitysvCM,...
        AverageoundVelocity,flag ]=textread(fl,...
            repmat('%f',1,23),'headerlines',389);
    ix1=Pressure>=20;
    ix2=Pressure<=26;
    id=ix1&ix2;
    
    x=datetime(2019,11,18,18,13,07);
    y=nanmean(Fluorescence(id));
    h2=plot(x,y,'m+','LineWidth',4);
end

title('Prize East 2018-2019')

legend([h1 h2],{'JR17006','KPH'})
ylim([0 5]);
ylabel('Fluorescence (mg/m^3)');
savename=['fluor_calibration'];
print(gcf, '-dpng',savename);


ylim([0 25]);
ylabel('Fluorescence (mg/m^3)');
savename=['fluor_East18'];
print(gcf, '-dpng',savename);