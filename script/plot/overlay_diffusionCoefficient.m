%% filename_array���J�X�^�}�C�Y���āA�C�ӂ̃f�[�^�Q�݂̂�overlay

% %% loop�񂷂ׂ��S�t�@�C�����擾
% files = dir(sprintf('measurement_conditions/%s/*.mat', DATE)); 
% filename_array = string({files.name});

%% �e��������ɂ���loop���đ��֊֐���overlay���Ă���
for idx=1:length(filename_array)
    clearvars -except filename_array DATE idx
    filename = filename_array(idx);
    
    %����f�[�^��load
    load(sprintf("workspace/%s/temporal_%s", DATE, filename),'modelfun', 'parms','TAU','sample_name')
    
    %�K�i�����ĂP < COR_normalized <�Q�ɂ���
    COR = modelfun(parms,TAU);
    COR_normalized = COR-1;
    COR_normalized = (COR_normalized ./ COR_normalized(1)) + 1; 
    
    %���֊֐�plot
    txt = [sample_name];
    semilogx(TAU, COR_normalized,'-o', 'DisplayName',txt)
    
%     %�}������Ă���
%     legend(sample_name, 'Location','northeast');
    
    hold on;
end

%% loop�I����AFig�ɐ���������
ax = gca; % current axes
ax.FontSize = 12;
xlabel("lagtime (s)", 'FontSize',14,'FontWeight','bold');
ylabel("Correlation Normalized", 'FontSize',14,'FontWeight','bold');

hold off

lgd = legend;
lgd.FontSize = 14;
lgd.Location = 'northeast';