%% �C���|�[�g
% ���[�N�X�y�[�X�̃N���A
clear; 

% ���ʑ�������i�v�ύX�I�I�j
DATE = "230112";
SP = 10.5;

%�p�X��ʂ�
addpath(genpath("function"));
addpath(genpath("script"));
addpath(genpath("output"));
addpath(genpath(sprintf("input/%s", DATE)));
addpath(genpath(sprintf("measurement_conditions/%s", DATE)));

%% mkdir (�쐬�����ׂ�directory���������݂��Ȃ��Ȃ�΁A�쐬����j
    for folder_name = [sprintf("output/%s", DATE)  sprintf("workspace/%s", DATE)]
        if not(exist(folder_name,'dir'))
            mkdir(folder_name)
        end
    end
%% �ŐV��measurement_conditions�𔽉f
    run(sprintf("script_conditions_%s.m", DATE));
%% loop�񂷂ׂ��S�t�@�C�����擾
files = dir(sprintf('measurement_conditions/%s/*.mat', DATE)); 
filename_array = string({files.name});
%% �d�v�ȃp�����[�^��ۑ�����\���̂𐶐�
COMPONENT = 2; %���f�����̐����̐�
if COMPONENT == 1
    important_parameters_struct = struct('sample_name',{}, 'diffusion_coefficient', {},  'diffusion_time', {}, 'w_radius', {}, 'dwell_time', {},'time_scale', {},'image_size', {});
elseif COMPONENT == 2
    disp("hello")
    important_parameters_struct = struct('sample_name',{}, 'fast_diffusion_coefficient', {},  'fast_diffusion_time', {}, 'slow_diffusion_coefficient', {},  'slow_diffusion_time', {},'fast_fraction',{},'slow_fraction',{}, 'w_radius', {}, 'dwell_time', {},'time_scale', {},'image_size', {});    
end

%% �e��������ɂ���loop
for idx=1:length(filename_array)
    clearvars -except filename_array DATE idx COMPONENT important_parameters_struct
    filename = filename_array(idx);
    sprintf("�t�@�C�����́@%s�@�ł�", filename_array(idx))
    %����f�[�^��load
    load(sprintf("measurement_conditions/%s/%s", DATE, filename))
   
    %% �u�����x�̎擾
    XT = imread(sprintf("input/%s/lsm/%s",DATE, filename));
    XT = double(XT);
    
    %����F�ɋN������A�u�����x�̌�����␳
    if isCorrected == "true"
        run("correct_intensity.m")
        XT = XT_corrected;
    end
    %% �I��
    %�@temporal(ksai=�萔) �Aspational(tau=�萔)�@�Bspatiotemporal
    choice = 5;
    %% ���֌v�Z
    if choice == 1 %temporal
        NUMBER_TAU = 100; % tau�̌��i������j��ݒ�
        %ACF
        [TAU, COR] = temporal_correlation(XT, TIME_SCALE, NUMBER_TAU);
        %Run Fitting
         run("fitting_temporal.mlx")
        %Run Plot
         run("temporal_plots.mlx")
        %Run Calculation for DiffusionCoefficient
         w_radius = 0.199; %[?]�@fcs��calibration��蓾��("calculate_w0.mlx")
         run("calculate_diffusion_coefficient.mlx")
        %Run compare 
         %run("compare_with_zen.mlx")
        %Save workspace
         save(sprintf('workspace/%s/temporal_%s.mat',DATE, filename))
        
        

    elseif choice == 2
        constant_T = 2;
        %ACF
        [KSAI, COR] = spatial_correlation(XT, X_SCALE, constant_T);
        %Fitting
        %Plot
        plot(KSAI,COR)
        %semilogx(TAU,COR)
        xlabel('�� (��m)','FontSize',14,'FontWeight','bold');
        ylabel('Correlation(��)','FontSize',14,'FontWeight','bold');

    elseif choice == 3
        %ACF
        [KSAI, TAU, COR] = spatiotemporal_correlation(XT,TIME_SCALE,X_SCALE);
        COR(isnan(COR)) = 0; %NaN��0�ɒu������
       %% 

        %Run fitting
        SP = 7;
        run("fitting_spatiotemporal.mlx")

        %Run plot
        run("spatiotemporal_plots.mlx")
        
    elseif choice == 4
        constant_X = 3  ;
        %ACF
        [TAU, COR] = xcorr_temporal_correlation(XT, TIME_SCALE, constant_X);
        %Fitting
        run("fitting_temporal.mlx")
        %Plot
        semilogx(TAU,COR)
        xlabel('�� (s)');
        ylabel('Correlation(��)');
        
    elseif choice == 5
    constant_X = 3 ;
    NUMBER_TAU = 100; % tau�̌��i������j��ݒ�
    %ACF
    [TAU, COR] = constantX_temporal_correlation(XT, TIME_SCALE, constant_X, NUMBER_TAU);
    %Run Fitting
     run("fitting_temporal.mlx")
    %Run Plot
     run("temporal_plots.mlx")
    %Run Calculation for DiffusionCoefficient
     w_radius = 0.151; %[?]�@fcs��calibration��蓾��("calculate_w0.mlx")
     run("calculate_diffusion_coefficient.mlx")
    %Run compare 
     %run("compare_with_zen.mlx")
    %Save workspace
     save(sprintf('workspace/%s/X_temporal_%s.mat',DATE, filename))


    end
%     %% save result on workspace file
%     save(sprintf('workspace/%s/%s.mat',DATE, filename))
%     clearvars -except filename_array DATE
end

%% �g�U�W���Ȃǂ̑厖�ȃp�����[�^���i�[�����\���̂�ۑ�
save(sprintf('workspace/%s/important_parameters.mat',DATE), 'important_parameters_struct');