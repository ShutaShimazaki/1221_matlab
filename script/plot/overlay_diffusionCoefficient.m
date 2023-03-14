%% �K�i���������֊֐���overlay����t�@�C���ł�
% �����Fworkspace��filename_array�Ƃ����ϐ�����Aoverlay�������t�@�C�����݂̂��c��

%% �e��������ɂ���loop���đ��֊֐���overlay���Ă���
for idx=1:length(filename_array)
    clearvars -except filename_array DATE idx
    filename = filename_array(idx);
    
    %%����f�[�^��load
    %�S���̈ʒu
     %retrend
      load(sprintf("workspace/%s/temporal_%s", DATE, filename),'COR','TAU','sample_name','modelfun','parms')
    %��_
     %load(sprintf("workspace/%s/X_temporal_%s", DATE, filename),'COR','TAU','sample_name')
    
     COR  =modelfun(parms,TAU);
    % lagtime�̉��������킹��
    lagtime_min = 22 * 10^-3; % s
    COR_substracted = COR(TAU > lagtime_min);
    TAU_substracted = TAU(TAU > lagtime_min);
    %�K�i�����ĂP < COR_normalized <�Q�ɂ���
    COR_normalized = COR_substracted - 1;
    COR_normalized = (COR_normalized ./ COR_normalized(1)) + 1; 
    
    %�t�B�b�g���Ă��Ȃ����֊֐���plot
    txt = [sample_name];
    semilogx(TAU_substracted, COR_normalized,'-o', 'DisplayName',txt)
    
    hold on;
end

%% loop�I����AFig�ɐ���������
ax = gca; % current axes
ax.FontSize = 12;
xlabel("���ꎞ�� (s)", 'FontSize',14,'FontWeight','bold');
ylabel("�K�i���������֊֐�", 'FontSize',12,'FontWeight','bold');

hold off
%% Legend (https://jp.mathworks.com/help/matlab/ref/matlab.graphics.illustration.legend-properties.html)
lgd = legend;
lgd.Location = 'bestoutside';

%% save
% saveas(gcf, sprintf("output/%s/overlay_acf/TDP25 vs HSP70.fig",DATE));

saveas(gcf, sprintf("output/%s/overlay_acf/ %s etc.fig",DATE,txt));
saveas(gcf, sprintf("output/%s/overlay_acf/ %s etc.png",DATE,txt));