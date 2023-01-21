%script_spatiotemporal.mÇ©ÇÁåƒÇ—èoÇ∑ÅB
%SP = 10.5; %ATTO488_sol01
%% G-TDP25
sample_name = "GFP-TDP25 0.763ms";
filename = "G-TDP25_01_line1_0.762ms.lsm";

X_SCALE = 0.022; %É m
PIXEL_DWELL = 1.27 *10^(-6); %s
PIXEL = 256;
TIME_SCALE = 0.763 * 10^-3; %s              
TIME_SERIES = 50000;
IMAGE_SIZE = 5.63 %É m;

save(sprintf('measurement_conditions/%s/%s.mat',DATE, filename));
%% G-TDP25
sample_name = "GFP-TDP25 1.53ms";
filename = "G-TDP25_01_line2_1.53ms.lsm";

X_SCALE = 0.022; %É m
PIXEL_DWELL = 2.55 *10^(-6); %s
PIXEL = 256;
TIME_SCALE = 1.53 * 10^-3; %s      
TIME_SERIES = 50000;
IMAGE_SIZE = 5.63 %É m;
save(sprintf('measurement_conditions/%s/%s.mat',DATE, filename));

%% G-TDP25
sample_name = "GFP-TDP25 22.1ms";
filename = "G-TDP25_01_line3_22.12ms.lsm";

X_SCALE = 0.044; %É m
PIXEL_DWELL = 51.2 *10^(-6); %s
PIXEL = 256;
TIME_SCALE = 22.1 * 10^-3; %s      
TIME_SERIES = 5720;
IMAGE_SIZE = 11.25 %É m;
save(sprintf('measurement_conditions/%s/%s.mat',DATE, filename));

%% HSP70-G.lsm
sample_name = "HSP70-G 1.15ms";
filename = "HSP70-G_01_line_1.15ms.lsm";

X_SCALE = 0.023; %É m
PIXEL_DWELL = 1.97 *10^(-6); %s
PIXEL = 248;
TIME_SCALE = 1.15 * 10^-3; %s      
TIME_SERIES = 100000;
IMAGE_SIZE = 5.63 %É m;
save(sprintf('measurement_conditions/%s/%s.mat',DATE, filename));

%% 
sample_name = "HSP70-G 3.84ms";
filename = "HSP70-G_02_line_3.84ms.lsm";

X_SCALE = 0.045; %É m
PIXEL_DWELL = 6.61 *10^(-6); %s
PIXEL = 248;
TIME_SCALE = 3.85 * 10^-3; %s      
TIME_SERIES = 53204;
IMAGE_SIZE = 11.25 %É m;
save(sprintf('measurement_conditions/%s/%s.mat',DATE, filename));
%% 
sample_name = "HSP70-G 0.763ms";
filename = "HSP70-G_03_line_0.763ms.lsm";

X_SCALE = 0.022; %É m
PIXEL_DWELL = 1.27 *10^(-6); %s
PIXEL = 256;
TIME_SCALE = 0.763 * 10^-3; %s      
TIME_SERIES = 50000;
IMAGE_SIZE = 5.63 %É m;
save(sprintf('measurement_conditions/%s/%s.mat',DATE, filename));
%%
sample_name = "HSP70-G 3.07ms";
filename = "HSP70-G_04_line_3.07ms.lsm";

X_SCALE = 0.022; %É m
PIXEL_DWELL = 5.12 *10^(-6); %s
PIXEL = 256;
TIME_SCALE = 3.07 * 10^-3; %s      
TIME_SERIES = 50000;
IMAGE_SIZE = 5.63 %É m;
save(sprintf('measurement_conditions/%s/%s.mat',DATE, filename));
