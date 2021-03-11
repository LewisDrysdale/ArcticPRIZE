function [data]=prize_grid_linear_interp(structure,plot_dir,mooring,t_interp,z_interp,start_date,end_date,y_tol,stddy_tol,nloop)

%% interpolate on to time grid
% initialise empty arrays for grid
T=[];T_sbe=[];S_sbe=[];PRES_so=[];PRES_sbe=[];

% make time_grid
t_grid = start_date:t_interp:end_date;

for ii=1:numel(structure)
    
    % extract data to workspace variables
    temp    =structure(ii).temp;
    sal     =structure(ii).sal;
    pres    =structure(ii).pres;
    time    =structure(ii).time;
        
    %   Try despike salinity, replace bad values with NAN - SBE only!
    if ~isempty(sal)    
        [sal,dx,~] = ddspike(sal,y_tol,stddy_tol,[nloop],'y',NaN);
        
        % Replace contemperaneous temperatures with NAN
        temp(dx)         = NaN;
        
        % save de-spike plots
        ylabel('Salinity');
        title(['intrument sn ' num2str(structure(ii).sn)]);
        savename=[plot_dir filesep mooring '/despike_instrument_sn ' num2str(structure(ii).sn)];
        print(gcf,'-dpng',savename);       
        
        % interpolate salinity data
        S_sbe=[S_sbe;interp1(time, sal, t_grid)];
        T_sbe=[T_sbe;interp1(time, temp, t_grid)];
        PRES_sbe=[PRES_sbe;interp1(time, pres, t_grid)];
    else
        % Star-Odi data, has tempertaure only
        % interpolate temp, no despike
        T=[T;interp1(time, temp, t_grid)];
        PRES_so=[PRES_so; repmat(pres,1,numel(t_grid))];
    end

end

%% combine star odi temperatures and sbe temperatures and fill salinity array
S_fill  = NaN(size(T));% make nan array same size as temperature
S       = [S_fill; S_sbe];

T       = [T; T_sbe];
P       = [PRES_so; PRES_sbe];

% sort by pressure
[~,I]   = sort(P(:,10),1); % need non -nan column

% use index to populate arrays
P=P(I,:);T=T(I,:);S=S(I,:);

%% low-pass filter the data

t_res    = diff(t_grid(1:2));   % get temporal resolution of new grid
co       = 1/2;                 % filter cut off frequency [1/days]
fss      = 2;                   % final sub-sampling frequency [1/days]

% filter Temperature
for jj = 1:numel(P(:,1))
    t_nan = find(~isnan(T(jj,:)));
    p_nan = find(~isnan(P(jj,:)));
    Tf(jj,t_nan) = auto_filt(T(jj,t_nan),1/t_res,co);    
    % interpolate on to original grid
    Tf(jj,:)     = interp1(t_grid(t_nan),Tf(jj,t_nan)',t_grid)';
end

% % filter sbe Temperature
% for jj = 1:numel(P(:,1))
%     t_nan = find(~isnan(T(jj,:)));
%     p_nan = find(~isnan(P(jj,:)));
%     Tf_sbe(jj,t_nan) = auto_filt(T(jj,t_nan),1/t_res,co);    
%     % interpolate on to original grid
%     Tf_sbe(jj,:)     = interp1(t_grid(t_nan),Tf_sbe(jj,t_nan)',t_grid)';
% end

% filter sbe Salinity
for jj = 1:numel(P(:,1))
    s_nan = find(~isnan(S(jj,:)));
    if sum(s_nan)>1
        Sf(jj,s_nan) = auto_filt(S(jj,s_nan),1/t_res,co);    
        % interpolate on to original grid
        Sf(jj,:)     = interp1(t_grid(s_nan),Sf(jj,s_nan)',t_grid)';
    else
        Sf(jj,:)    = S(jj,:);
    end
end

% Filter pressue
for jj = 1:numel(P(:,1))
    p_nan = find(~isnan(P(jj,:)));
    if sum(p_nan)>1
        Pfs(jj,p_nan) = auto_filt(P(jj,p_nan),1/t_res,co);    
        % interpolate on to original grid
        Pfs(jj,:)     = interp1(t_grid(p_nan),Pfs(jj,p_nan)',t_grid)';
    else
            Pf(jj,:)    = P(jj,:);
    end
end

% no filter neccessary for star-odi data as pressure not sampled
    
% create new time grid
tgd   = start_date+2:1/fss:end_date-2;

% interpolate filtered data on to new grid
Tft      = interp1(t_grid,Tf',tgd)';
Sft      = interp1(t_grid,Sf',tgd)';
Pft      = interp1(t_grid,Pfs',tgd)';

%% make depth grid

pmin     = ceil(mmin(Pft)/z_interp)*z_interp;
pmax     = floor(mmax(Pft)/z_interp)*z_interp;
p_grid = [pmin:z_interp:pmax]';

%% interpolate salinity on to depth grid

SGfs = nan(length(p_grid),length(tgd)); 
for ijj=1:length(tgd)
     s_nan = find(~isnan(Sft(:,ijj)));
     SGfs(:,ijj) = interp1(Pft(s_nan,ijj),Sft(s_nan,ijj),p_grid) ; 
end

%% interpolate temperature on to depth grid

TGfs = nan(length(p_grid),length(tgd));
for ijj=1:length(tgd)
    TGfs(:,ijj) = interp1(Pft(:,ijj),Tft(:,ijj),p_grid) ;        
end

%% store the data
data.temp_filtered              =Tft; % filtered 6 hourly interpolated temperatures
data.sal_filtered               =Sft; % filtered 6 hourly interpolated salinity
data.pres_filtered              =Pft; % filtered 6 hourly interpolated pressure
data.temp_filtered_interpolated =TGfs;% filtered 6 hourly 10 m interpolated temp
data.sal_filtered_interpolated  =SGfs;% filtered 6 hourly 10 m interpolated sal
data.pres_grid                  =p_grid; % pressure grid for interpolated data
data.temp                       =T;   % all temperatures 6 hour grid
data.sal                        =S;   % all salinity 6 hour grid
data.pres                       =P;   % all pres 6 hour grid
data.time_grid                  =t_grid; % 6 hour time grid

%% plot the salinity data 
figure(1);
ax(1)=subplot(3,1,1);
[c,h]=contourf(S_sbe);
axis ij
cmocean('haline')
colorbar
title('Temporally interpolated')

ax(2)=subplot(3,1,2);
[c,h]=contourf(Sft(any(~isnan(Sft), 2), :));
axis ij
cmocean('haline')
colorbar
title('Temporally interpolated and Low pass filtered')

ax(3)=subplot(3,1,3);
[c,h]=contourf(tgd,p_grid,SGfs);
axis ij
datetick('x',12,'keepticks')
cmocean('haline')
colorbar
title('Vertically Interpolated and low pass filtered')

savename=[plot_dir filesep mooring filesep mooring '_salinity_grid'];
print(gcf, '-dpng',savename);


%% plot the temperature data 
figure(2);
ax(1)=subplot(3,1,1)
[c,h]=contourf(T);
axis ij
cmocean('thermal')
colorbar
title('Temporally interpolated')

ax(2)=subplot(3,1,2)
[c,h]=contourf(Tft);
axis ij
cmocean('thermal')
colorbar
title('Temporally interpolated and Low pass filtered')

ax(3)=subplot(3,1,3)
[c,h]=contourf(tgd,p_grid,TGfs);
axis ij
datetick('x',12,'keepticks')
cmocean('thermal')
colorbar
title('Vertically Interpolated and low pass filtered')

savename=[plot_dir filesep mooring filesep mooring '_temp_grid'];
print(gcf, '-dpng',savename);