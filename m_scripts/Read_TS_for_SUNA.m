clearvars; close('all');
% Sian needs TS data in a specific format for instruments nearest SUNA for 
% 18-19. Would be great for Lewis to liaise with her on that one. 
% Eastern mooring will be SBE 16, western will be Microcat 
% (one SBE16 flooded in first deployment)

%% EASTERN MOORING
% load data from SBE16 at 24.5 m
load('matlab/EAST_18.mat', 'sal50214', 'temp50214', 'time50214')

% get time
time=datestr(time50214,'YYYY-MM-DD hh:mm:ss');

% get temp
temp=temp50214;

% set sal
sal=sal50214;

% try with matlab writetable
T=table(time,temp,sal);

% convert to comma delimited text file
writetable(T,'SBE16_50214_SUNA_EAST_18.csv',...
    'Delimiter',',',...
    'WriteVariableNames',0);

writetable(T,'SBE16_50214_SUNA_EAST_18.txt',...
    'Delimiter',',',...
    'WriteVariableNames',0);
%% WESTERN MOORING
% load data from SBE37 microcat at 26 m
load('matlab/WEST_18.mat', 'sal9382', 'temp9382', 'time9382')

% get time
time=datestr(time9382,'YYYY-MM-DD hh:mm:ss');

% get temp
temp=temp9382;

% set sal
sal=sal9382;

% try with matlab writetable
T=table(time,temp,sal);

% convert to comma delimited text file
writetable(T,'SBE37_9382_SUNA_WEST_18.csv',...
    'Delimiter',',',...
    'WriteVariableNames',0);

writetable(T,'SBE37_9382_SUNA_WEST_18.txt',...
    'Delimiter',',',...
    'WriteVariableNames',0);

