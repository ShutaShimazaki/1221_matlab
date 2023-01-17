%script_spatiotemporal.mÇ©ÇÁåƒÇ—èoÇ∑ÅB
%SP = 19.7;
%% 20nm_pixelsize90nm_dwell5micro_total76s.lsm
sample_name = "20nm";
filename = "20nm_pixelsize90nm_dwell5micro_total76s.lsm";

X_SCALE = 0.088; %É m
PIXEL_DWELL = 5.09 *10^(-6); %s
PIXEL = 64;
TIME_SCALE = 0.763 * 10^-3; %s              
TIME_SERIES = 100000;

save(sprintf('measurement_conditions/%s/%s.mat',DATE, filename));
%% 100nm_pixelsize90nm_dwell13micro_total96s.lsm
sample_name = "100nm";
filename = "100nm_pixelsize90nm_dwell13micro_total96s.lsm";

X_SCALE = 0.088; %É m
PIXEL_DWELL = 12.8 *10^(-6); %s
PIXEL = 64;
TIME_SCALE = 1.93 * 10^-3; %s      
TIME_SERIES = 50000;
save(sprintf('measurement_conditions/%s/%s.mat',DATE, filename));

%% 200nm_pixelsize90nm_dwell13micro_total96s.lsm
sample_name = "200nm";
filename = "200nm_pixelsize90nm_dwell13micro_total96s.lsm";

X_SCALE = 0.088; %É m
PIXEL_DWELL = 12.8 *10^(-6); %s
PIXEL = 64;
TIME_SCALE = 1.93 * 10^-3; %s      
TIME_SERIES = 50000;
save(sprintf('measurement_conditions/%s/%s.mat',DATE, filename));

%% 100nm_SCROSE30%_pixelsize90nm_dwell26micro_total110s.lsm
sample_name = "100nm SCROSE30%";
filename = "100nm_SCROSE30%_pixelsize90nm_dwell26micro_total110s.lsm";

X_SCALE = 0.088; %É m
PIXEL_DWELL = 25.6 *10^(-6); %s
PIXEL = 64;
TIME_SCALE = 3.836 * 10^-3; %s      
TIME_SERIES = 30000;
save(sprintf('measurement_conditions/%s/%s.mat',DATE, filename));

%% 100nm_SCROSE40%_pixelsize90nm_dwell26micro_total110s.lsm
sample_name = "100nm SCROSE40%";
filename = "100nm_SCROSE40%_pixelsize90nm_dwell26micro_total110s.lsm";

X_SCALE = 0.088; %É m
PIXEL_DWELL = 25.6 *10^(-6); %s
PIXEL = 64;
TIME_SCALE = 3.836 * 10^-3; %s      
TIME_SERIES = 30000;
save(sprintf('measurement_conditions/%s/%s.mat',DATE, filename));
%% 100nm_SCROSE50%_pixelsize90nm_dwell26micro_total110s.lsm
sample_name = "100nm SCROSE50%";
filename = "100nm_SCROSE50%_pixelsize90nm_dwell26micro_total110s.lsm";

X_SCALE = 0.088; %É m
PIXEL_DWELL = 25.6 *10^(-6); %s
PIXEL = 64;
TIME_SCALE = 3.836 * 10^-3; %s      
TIME_SERIES = 30000;
save(sprintf('measurement_conditions/%s/%s.mat',DATE, filename));
