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

%% low-pass filter the data

t_res    = diff(t_grid(1:2));   % get temporal resolution of new grid
co       = 1/2;                 % filter cut off frequency [1/days]
fss      = 2;                   % final sub-sampling frequency [1/days]

% filter Temperature
for jj = 1:numel(PRES_so(:,1))
    t_nan = find(~isnan(T(jj,:)));
    p_nan = find(~isnan(PRES_so(jj,:)));
    Tf(jj,t_nan) = auto_filt(T(jj,t_nan),1/t_res,co);    
    % interpolate on to original grid
    Tf(jj,:)     = interp1(t_grid(t_nan),Tf(jj,t_nan)',t_grid)';
end

% filter Salinity
for jj = 1:numel(PRES_sbe(:,1))
    s_nan = find(~isnan(S_sbe(jj,:)));
    p_nan = find(~isnan(PRES_sbe(jj,:)));
    Sf(jj,s_nan) = auto_filt(S_sbe(jj,s_nan),1/t_res,co);    
    % interpolate on to original grid
    Sf(jj,:)     = interp1(t_grid(s_nan),Sf(jj,s_nan)',t_grid)';
end

% Filter pressue
for jj = 1:numel(PRES_sbe(:,1))
    p_nan = find(~isnan(PRES_sbe(jj,:)));
    Pfs(jj,p_nan) = auto_filt(PRES_sbe(jj,p_nan),1/t_res,co);    
    % interpolate on to original grid
    Pfs(jj,:)     = interp1(t_grid(p_nan),Pfs(jj,p_nan)',t_grid)';
end

% no filter neccessary for star-odi data as pressure not sampled
Pf  = PRES_so;
    
% create new time grid
tgd   = start_date+2:1/fss:end_date-2;

% interpolate filtered data on to new grid
Tft      = interp1(t_grid,Tf',tgd)';
Pft      = interp1(t_grid,Pf',tgd)';
Sfs      = interp1(t_grid,Sf',tgd)';
Pfs      = interp1(t_grid,Pfs',tgd)';

%% interpolate salinity on to depth grid
pmin     = ceil(mmin(Pfs)/z_interp)*z_interp;
pmax     = floor(mmax(Pfs)/z_interp)*z_interp;
p_grid_s = [pmin:z_interp:pmax]';

SGfs = nan(length(p_grid_s),length(tgd)); 
for ijj=1:length(tgd)
    SGfs(:,ijj) = interp1(Pfs(:,ijj),Sfs(:,ijj),p_grid_s) ;        
end

%% interpolate temperature on to depth grid
pmin     = ceil(mmin(Pft)/z_interp)*z_interp;
pmax     = floor(mmax(Pft)/z_interp)*z_interp;
p_grid_t = [pmin:z_interp:pmax]'

TGfs = nan(length(p_grid_t),length(tgd));
for ijj=1:length(tgd)
    TGfs(:,ijj) = interp1(Pft(:,ijj),Tft(:,ijj),p_grid_t) ;        
end

%% store the data
data.temp_filtered              =Tft; % filtered interpolated temperatures
data.sal_filtered               =Sfs; % filtered interpolated salinity
data.pres_sto_filt              =Pft; % 
data.pres_sbe_filt              =Pfs;
data.temp_filtered_interpolated =TGfs;
data.sal_filtered_interpolated  =SGfs;
data.pres_grid_temp             =p_grid_t;
data.pres_grid_sal              =p_grid_s;
data.temp_sto                   =T;
data.sal_sbe                    =S_sbe;
data.temp_sbe                   =T_sbe;
data.pres_sbe                   =PRES_sbe;
data.depth_sto                  =PRES_so;
data.time_grid                  =t_grid;

%% plot the salinity data 
figure(1);
ax(1)=subplot(3,1,1);
[c,h]=contourf(S_sbe);
axis ij
cmocean('haline')
colorbar
title('Temporally interpolated')

ax(2)=subplot(3,1,2);
[c,h]=contourf(Sfs);
axis ij
cmocean('haline')
colorbar
title('Temporally interpolated and Low pass filtered')

ax(3)=subplot(3,1,3);
[c,h]=contourf(tgd,p_grid_s,SGfs);
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
[c,h]=contourf(tgd,p_grid_t,TGfs);
axis ij
datetick('x',12,'keepticks')
cmocean('thermal')
colorbar
title('Vertically Interpolated and low pass filtered')

savename=[plot_dir filesep mooring filesep mooring '_temp_grid'];
print(gcf, '-dpng',savename);