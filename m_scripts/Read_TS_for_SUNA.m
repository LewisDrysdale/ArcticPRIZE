clearvars; close('all');
% Sian needs TS data in a specific format for instruments nearest SUNA for 
% 18-19. Would be great for Lewis to liaise with her on that one. 
% Eastern mooring will be SBE 16, western will be Microcat 
% (one SBE16 flooded in first deployment)

%% EASTERN MOORING
% load data from SBE16 at 24.5 m
load('C:\Users\SA01LD\Desktop\PRIZE_18_19\data\moor_processed/EAST_18.mat')

% get time
time=datestr(prize_east_18(1).time,31);

% get temp
temp=prize_east_18(1).temp;

% set sal
sal=prize_east_18(1).sal;

% try with matlab writetable
T=table(time,temp,sal);

% convert to comma delimited text file
writetable(T,'C:\Users\SA01LD\OneDrive - SAMS\PRIZE\SIAN_nuts\SBE16_50214_SUNA_EAST_18.csv',...
    'Delimiter',',',...
    'WriteVariableNames',0);

writetable(T,'C:\Users\SA01LD\OneDrive - SAMS\PRIZE\SIAN_nuts\SBE16_50214_SUNA_EAST_18.txt',...
    'Delimiter',',',...
    'WriteVariableNames',0);
%% WESTERN MOORING
% load data from SBE37 microcat at 26 m
load('C:\Users\SA01LD\Desktop\PRIZE_18_19\data\moor_processed/WEST_18.mat')

% get time
time=datestr(prize_west_18(1).time,31);

% get temp
temp=prize_west_18(1).temp;

% set sal
sal=prize_west_18(1).sal;

% try with matlab writetable
T=table(time,temp,sal);

% convert to comma delimited text file
writetable(T,'C:\Users\SA01LD\OneDrive - SAMS\PRIZE\SIAN_nuts\SBE37_9382_SUNA_WEST_18.csv',...
    'Delimiter',',',...
    'WriteVariableNames',0);

writetable(T,'C:\Users\SA01LD\OneDrive - SAMS\PRIZE\SIAN_nuts\SBE37_9382_SUNA_WEST_18.txt',...
    'Delimiter',',',...
    'WriteVariableNames',0);

