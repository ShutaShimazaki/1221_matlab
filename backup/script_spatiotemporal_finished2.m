%% �I��
%�@temporal(ksai=�萔) �Aspational(tau=�萔)�@�Bspatiotemporal
choice = 2;

%% �������
X_SCALE = 0.176; %��m
PIXEL_DWELL = 25.7*10^(-6); %s
PIXEL = 32;
TIME_SCALE = 1.93 * 10^-3; %�������line_scan�ɂ����āA���̈ʒu�ɖ߂��Ă���܂ł̎��ԊԊu�BZEN�A�v������m�F����B
TIME_SERIES = 1000;

%% �C���|�[�g
addpath("function");
folderpath = "input/221028/100nm10000_pix180nm_T1.9ms_dwell25micro.lsm";
%folderpath = "input/221017/Retry after explanation/28nm_zoom35 - �R�s�[.lsm";
XT = imread(sprintf("%s", folderpath));
XT = double(XT); 

%% ���֌v�Z
if choice == 1
    KSAI = 3;
    %ACF
    [TAU, COR] = temporal_correlation(XT, TIME_SCALE, KSAI);
    %Fitting
    %Plot
    semilogx(TAU,COR)
    %semilogx(TAU,COR)
    xlabel('�� (s)');
    ylabel('Correlation(��)');
    
elseif choice == 2
    TAU = 4;
    %ACF
    [KSAI, COR] = spatial_correlation(XT, X_SCALE, TAU);
    %Fitting
    %Plot
    plot(KSAI,COR)
    %semilogx(TAU,COR)
    xlabel('�� (��m)');
    ylabel('Correlation(��)');
elseif choice == 3
end