%%% LSM�����������͂��邽�߂̃e���v���[�g�t�@�C���ł� %%%

%���̃t�@�C���͓��͂�����������l���i�[�������[�N�X�y�[�X�t�@�C���𐶐����܂��B
%���ۂ̑�������ɉ����Ēl��ύX���Ă�������
%�S�T���v���E�S�����������͂��Ă��������B�i����SAMPLE1, 2�݂̂ł����A�R�s�y���Ă����Ă��������j
 %������؁Ffilename��input>DATE>lsm�t�H���_���ɉ�����lsm�t�@�C���̖��O�ɂ���B����
 
%%%
%% G-TDP25
%�����������
sample_name = "GFP-TDP25 0.763ms"; %sample_name: �C�� (�쐬�����v���b�g�}��title�ɂȂ�܂��j
filename = "G-TDP25_01_line1_0.762ms.lsm"; %input>DATE>lsm�t�H���_���ɉ�����lsm�t�@�C���̖��O�ɂ���B
isCorrected = "false"; %����F��␳����K�v�����邩�Ȃ����B�ifalse��true�Ŏw��B�f�t�H���g��false=�Ȃ��j

X_SCALE = 0.022; %��m�@
PIXEL_DWELL = 1.27 *10^(-6); %s
PIXEL = 256;
TIME_SCALE = 0.763 * 10^-3; %s�@���̈ʒu�ɂ��ǂ��Ă���܂ł̎���              
TIME_SERIES = 50000;
IMAGE_SIZE = 5.63; %��m

%���[�N�X�y�[�X�t�@�C���̐���
save(sprintf('measurement_conditions/%s/%s.mat',DATE, filename));

%% G-TDP25
%�����������
sample_name = "GFP-TDP25 1.53ms";
filename = "G-TDP25_01_line2_1.53ms.lsm";
isCorrected = "false";

X_SCALE = 0.022; %��m
PIXEL_DWELL = 2.55 *10^(-6); %s
PIXEL = 256;
TIME_SCALE = 1.53 * 10^-3; %s      
TIME_SERIES = 50000;
IMAGE_SIZE = 5.63; %��m

%���[�N�X�y�[�X�t�@�C���̐���
save(sprintf('measurement_conditions/%s/%s.mat',DATE, filename));
