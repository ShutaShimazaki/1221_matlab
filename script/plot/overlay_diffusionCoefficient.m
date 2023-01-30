%% filename_array���J�X�^�}�C�Y���āA�C�ӂ̃f�[�^�Q�݂̂�overlay

% %% loop�񂷂ׂ��S�t�@�C�����擾
% files = dir(sprintf('measurement_conditions/%s/*.mat', DATE)); 
% filename_array = string({files.name});

%% �e��������ɂ���loop���đ��֊֐���overlay���Ă���
for idx=1:length(filename_array)
    
    clearvars -except filename_array DATE idx
    filename = filename_array(idx);
    
    %%����f�[�^��load
    %�S���̈ʒu
     load(sprintf("workspace/%s/temporal_%s", DATE, filename),'COR','TAU','sample_name','modelfun','parms')
    %��_
     %load(sprintf("workspace/%s/X_temporal_%s", DATE, filename),'COR','TAU','sample_name')
    
%     %�t�B�b�g��
%     COR = modelfun(parms,TAU);
    %�K�i�����ĂP < COR_normalized <�Q�ɂ���
    COR_normalized = COR-1;
    COR_normalized = (COR_normalized ./ COR_normalized(1)) + 1; 
    
    %�t�B�b�g���Ă��Ȃ����֊֐���plot
    txt = [sample_name];
    semilogx(TAU, COR_normalized,'-o', 'DisplayName',txt)
    
    hold on;
end

%% loop�I����AFig�ɐ���������
ax = gca; % current axes
ax.FontSize = 12;
% xlabel("lagtime (s)", 'FontSize',14,'FontWeight','bold');
% ylabel("Correlation Normalized", 'FontSize',14,'FontWeight','bold');
xlabel("���ꎞ�� (s)", 'FontSize',14,'FontWeight','bold');
ylabel("�K�i���������֊֐�", 'FontSize',12,'FontWeight','bold');

hold off

%% Legend (https://jp.mathworks.com/help/matlab/ref/matlab.graphics.illustration.legend-properties.html)
lgd = legend;
% lgd.FontSize = 14;
%lgd.Location = 'northoutside';
lgd.Location = 'bestoutside';

%% save
% saveas(gcf, sprintf("output/%s/overlay_acf/TDP25 vs HSP70.fig",DATE));

saveas(gcf, sprintf("output/%s/overlay_acf/retrend %s etc.fig",DATE,txt));
saveas(gcf, sprintf("output/%s/overlay_acf/retrend %s etc.png",DATE,txt));