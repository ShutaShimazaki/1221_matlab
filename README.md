# Scanning FCS
## �ł��邱��
+ �u�����x�����̕␳<br>
+ �␳�����u�����x�Ɋ�Â����֊֐��̌v�Z<br>
�����ԑ��ցi�e�s�N�Z���̕��ρj/���ԑ��ցi�C�ӂ̂P�s�N�Z���j/ ����ԑ��ց@����I����
+ ���֊֐��̃t�B�b�e�B���O<br>
���P�����g�U/�Q�����g�U���f����I����
+ ���֊֐��̃v���b�g<br>
+ �g�U���ԁA�g�U�W���̓��o
 
## �g����
���FDATE = yymmdd�̌`�ɂ��Ă������� (��F23�N�P��12���� 230112)

### �@LSM�f�[�^��������<br>
+ input > DATE > lsm > �Slsm�t�@�C���@�Ƃ����K�w�\���ɂ���<br>
(��Finput > 230112 > lsm > G-TDP25_01_line1_0.762ms.lsm, G-TDP25_01_line2_1.53ms.lsm�E�E)

### �A��������̓���<br>
 "script_conditions_DATE.m"�i���e���v���[�g�t�@�C���j�𕡐�����<br>
+measurement_conditions > DATE > script_conditions_DATE.m�@�Ƃ����K�w�\���ɂ���<br>
(��Fmeasurement_conditions > 230112 > script_conditions_230112.m)

+ "script_conditions_DATE.m"�����������ɉ����ĕύX<br>
filename: ��L�@�ɂ�����input>DATE>lsm�t�H���_���ɉ�����lsm�t�@�C���̖��O�ɂ���B<br>
�i��Ffilename = G-TDP25_01_line1_0.762ms.lsm, filename = G-TDP25_01_line2_1.53ms.lsm)

### �Bmain�t�@�C���𓮂���<br>
1. "main_template.m"�𕡐����āA�ʂ�main�t�@�C��������
2. �X�N���v�g�㕔�́w�v�ύX�I�I�x�Z�N�V������K�X����<br>
3. ���s�i�΂̎O�p�{�^���������j

**���s���ē�������̂ƕۑ��ꏊ**<br>
���v���b�g��png�`��, fig�`��(matlab�ŊJ����)�̗����ŕۑ�����܂���<br>
+ �␳�O�ƕ␳��̌u�����x�v���b�g<br>��"output/DATE/sample_name"�t�H���_��<br>
+ ACF�v���b�g<br>��"output/DATE/sample_name"�t�H���_��<br>
+ �g�U�W���A�g�U���ԂȂǂ̃p�����[�^<br>��"workspace/DATE/important_parameters.mat"<br>
+ ���[�N�X�y�[�X�i�v���O�������s���̕ϐ�)<br>��"workspace/DATE/ACF�̎��_filename.mat"<br>

## �f��

## ����
### �G���[���b�Z�[�W�Ɖ�����<br>
�@fitting�ł̃G���[<br>
�����l��ς���Ƃ��܂�����

�A�t�@�C����t�H���_�����݂��Ȃ��Ƃ����G���[���b�Z�[�W<br>
�Escript_conditions�t�@�C���ɓ��͂���"filename"���Ԉ���Ă���\��������܂��B<br>
��input�t�H���_�ɉ�����lsm�t�@�C�����ƈ�v������悤�ɂ��Ă��������B�����Č�܂������O�����t�@�C����measurement_conditions�t�H���_�ɑ��݂��Ă���\��������܂��̂ō폜���Ă��������B

### �ꍇ�ɉ����ĕύX
+ �т̊Ԋu�ݒ�F"temporal_correlation.m" ��TAU_BETWEEN�Ƃ����ϐ��Œ�`<br>
+ �т̌�����F"main.m"��NUMBER_TAU�Ƃ����ϐ��Œ�`<br>
**�f�t�H���g�F��= TAU_BETWEEN *TIME_SCALE **<br>
�ETAU_BETWEEN = 10^0�`10^3�͈̔͂őΐ��I�ɓ��Ԋu��100�̓_=[1,2,3,�E�E, 870,933,1000]<br>
�ETIME_SCALE���X�L�����Ō��̃s�N�Z���ɖ߂��Ă���܂ł̎���

## �A��
mail to: zakishima.39@icloud.com

## ���̑��@�g���Ă������� ![](images_onREADME/)
### �g�U�W���̃v���b�g
+ **������**<br>
![ex](images_onREADME/�r�[�Y�a�Ɗg�U�W��.png)<br>
+ **���@**
1. workspace�t�@�C����important_parameters�Ƃ����ϐ��̒��g���݂�<br>
![important_parameters](images_onREADME/important_parameters.png)<br>
2. �ȉ��̃t�@�C���֓\��t����<br>
banana > shimazaki > ��� > "�g�U�W���v���b�g�e���v���[�g"

### �����̑��֊֐��v���b�g<br>
+ **������**<br>
![ex2](images_onREADME/200nm_etc.png)<br>

+ **���@**<br>
 script > plot > overlay_diffusionCoefficient.m���g�p<br>
�P�P�̑��֊֐����c��1�`�Q�ɋK�i�����A�d�˂邱�Ƃ��ł��܂�
�����m�F��A�f������B�e