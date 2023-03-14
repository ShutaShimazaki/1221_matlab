%%%%%%% main�t�@�C���T�v %%%%%%%
% ACF�v�Z�A�t�B�b�e�B���O�A�v���b�g�������ōs���܂�
% ACF�v���b�g�A�e�ϐ���ۑ��������[�N�X�y�[�X�A�d�v�ȃp�����[�^
%%%%%%%%%%%%%%
%% ���[�N�X�y�[�X�̃N���A
clear; 
%% �v�ύX�I�I%%%
DATE = "230112"; %yymmdd
SP = 10.5; %structual parameter (�Z���T���v���𑪒肵ZEN�ŉ�͂��ē����l����́j
w_radius = 0.199; %�ώ@�̐ς̔��a����� �iformula > calculate_w0.mlx�t�@�C�������s����ƌv�Z���Ă����j
COMPONENT = 2; %�t�B�b�g���f�����̊g�U�����̐��i�P���Q��I���B�ڍׂ�"script>fitting>fitting_temporal.mlx"���Q�ƁB�j
choice = 1; %�v�Z������ACF�̎�ނ�I��
% �@���ԑ���(�f�t�H���g�B�e�s�N�Z���̎��ԑ��ւ̕��ρB) �A���ԑ���(�C�ӂ̂P�s�N�Z���j�B����ԑ��ց@
%% �p�X��ʂ�
addpath(genpath("function"));
addpath(genpath("script"));
addpath(genpath("output"));
addpath(genpath(sprintf("input/%s", DATE)));
addpath(genpath(sprintf("measurement_conditions/%s", DATE)));

%% �ŐV��measurement_conditions�𔽉f
    run(sprintf("script_conditions_%s.m", DATE));
%% loop�񂷂ׂ��S�t�@�C�����擾
files = dir(sprintf('measurement_conditions/%s/*.mat', DATE)); 
filename_array = string({files.name});
%% �d�v�ȃp�����[�^(�g�U�W���Ȃǁj��ۑ������\���̂𐶐�
if COMPONENT == 1
    important_parameters_struct = struct('sample_name',{}, 'diffusion_coefficient', {},  'diffusion_time', {}, 'w_radius', {}, 'dwell_time', {},'time_scale', {},'image_size', {});
elseif COMPONENT == 2
    important_parameters_struct = struct('sample_name',{}, 'fast_diffusion_coefficient', {},  'fast_diffusion_time', {}, 'slow_diffusion_coefficient', {},  'slow_diffusion_time', {},'fast_fraction',{},'slow_fraction',{}, 'w_radius', {}, 'dwell_time', {},'time_scale', {},'image_size', {});    
end

%% mkdir (�쐬�����ׂ�directory���������݂��Ȃ��Ȃ�΁A�����쐬���Ă����j
for folder_name = [sprintf("output/%s", DATE)  sprintf("workspace/%s", DATE) sprintf("output/%s/%s", DATE, sample_name) sprintf("output/%s/%s", DATE, sample_name)]
    if not(exist(folder_name,'dir'))
        mkdir(folder_name)
    end
end
%% �e��������ɂ���loop
for idx=1:length(filename_array)
    clearvars -except filename_array DATE idx COMPONENT important_parameters_struct choice�@w_radius
    filename = filename_array(idx);
    sprintf("�t�@�C�����́@%s�@�ł�", filename_array(idx))
    %����f�[�^��load
    load(sprintf("measurement_conditions/%s/%s", DATE, filename))
   
    %% LSM�t�@�C�����C���|�[�g
    XT = imread(sprintf("input/%s/lsm/%s",DATE, filename));
    XT = double(XT);
    
    %% ����F�ɂ��u�����x�̌�����␳����
    run("correct_intensity.m")
    XT = XT_corrected;
    %% ���֌v�Z
    if choice == 1 %%�e�s�N�Z���ɂ����鎞�ԑ��ւ̕��ς��v�Z����
        NUMBER_TAU = 100; % tau�̌��i������j��ݒ�
        %ACF
        [TAU, COR] = temporal_correlation(XT, TIME_SCALE, NUMBER_TAU);
        %Run Fitting
         run("fitting_temporal.mlx")
        %Run Plot
         run("temporal_plots.mlx")
        %Run Calculation for DiffusionCoefficient
         run("calculate_diffusion_coefficient.mlx")
        %Run compare 
         %run("compare_with_zen.mlx")
        %Save workspace
         save(sprintf('workspace/%s/temporal_%s.mat',DATE, filename))
        
      elseif choice == 2 %��_X�i��1�s�N�Z��)��I���B���̃s�N�Z�������̎��ԑ��ւ��v�Z����
        constant_X = 3 ; 
        NUMBER_TAU = 100; % tau�̌��i������j��ݒ�
        %ACF
        [TAU, COR] = constantX_temporal_correlation(XT, TIME_SCALE, constant_X, NUMBER_TAU);
        %Run Fitting
         run("fitting_temporal.mlx")
        %Run Plot
         run("temporal_plots.mlx")
        %Run Calculation for DiffusionCoefficient
         run("calculate_diffusion_coefficient.mlx")
        %Run compare 
         %run("compare_with_zen.mlx")
        %Save workspace
         save(sprintf('workspace/%s/X_temporal_%s.mat',DATE, filename))
         
    elseif choice == 3 %����ԑ���
        %ACF
        [KSAI, TAU, COR] = spatiotemporal_correlation(XT,TIME_SCALE,X_SCALE);
        COR(isnan(COR)) = 0; %NaN��0�ɒu������
        %Run fitting
        run("fitting_spatiotemporal.mlx")
        %Run plot
        run("spatiotemporal_plots.mlx")
        %Save workspace
         save(sprintf('workspace/%s/spatiotemporal_%s.mat',DATE, filename))
    end
end

%% �g�U�W���Ȃǂ̑厖�ȃp�����[�^���i�[�����\���̂�ۑ�
save(sprintf('workspace/%s/important_parameters.mat',DATE), 'important_parameters_struct');
disp("---- Done! ----")