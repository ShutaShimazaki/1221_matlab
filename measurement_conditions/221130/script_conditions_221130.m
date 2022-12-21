%script_spatiotemporal.mÇ©ÇÁåƒÇ—èoÇ∑ÅB
%SP=11.8
%% 20nm_pixelsize90nm_dwell5micro_total76s.lsm
beads_size = "20nm";
filename = "28nm1000_scanMAX_laser3.lsm";

X_SCALE = 0.088; %É m
PIXEL_DWELL = 5.09 *10^(-6); %s
PIXEL = 64;
TIME_SCALE = 0.764 * 10^-3; %s              
TIME_SERIES = 1000;
save(sprintf('measurement_conditions/%s/%s.mat',DATE, filename));
%% 100nm_pixelsize90nm_dwell13micro_total96s.lsm
beads_size = "100nm";
filename = "100nm10000_pix180nm_T1.9ms_dwell25micro_time3000.lsm";

X_SCALE = 0.176; %É m
PIXEL_DWELL = 25.7 *10^(-6); %s
PIXEL = 32;
TIME_SCALE = 1.93 * 10^-3; %s      
TIME_SERIES =3000;
save(sprintf('measurement_conditions/%s/%s.mat',DATE, filename));

%% 200nm_pixelsize90nm_dwell13micro_total96s.lsm
beads_size = "200nm";
filename = "200nm10000_pix120nm_T3.84ms_dwell34micro_time5000_laser3.lsm";

X_SCALE = 0.117; %É m
PIXEL_DWELL = 34.3 *10^(-6); %s
PIXEL = 48;
TIME_SCALE = 3.84 * 10^-3; %s      
TIME_SERIES = 5000;
save(sprintf('measurement_conditions/%s/%s.mat',DATE, filename));

%% 100nm_SCROSE30%_pixelsize90nm_dwell26micro_total110s.lsm
beads_size = "100nm";
filename = "100nm_scrose30%SOLVENT_1000_pix180nm_T1.9ms_dwell25micro_time3000.lsm";

X_SCALE = 0.176; %É m
PIXEL_DWELL = 25.7 *10^(-6); %s
PIXEL = 32;
TIME_SCALE = 1.93 * 10^-3; %s      
TIME_SERIES = 3000;
save(sprintf('measurement_conditions/%s/%s.mat',DATE, filename));

%% 100nm_SCROSE50%_pixelsize90nm_dwell26micro_total110s.lsm
beads_size = "100nm";
filename = "100nm_scrose50%SOLVENT_1000_pix60nm_T7.67ms_dwell34.3micro_time3000.lsm";

X_SCALE = 0.059; %É m
PIXEL_DWELL = 34.3 *10^(-6); %s
PIXEL = 96;
TIME_SCALE = 7.67 * 10^-3; %s      
TIME_SERIES = 3000;
save(sprintf('measurement_conditions/%s/%s.mat',DATE, filename));
