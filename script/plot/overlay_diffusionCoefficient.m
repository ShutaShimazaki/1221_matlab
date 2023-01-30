%% filename_arrayをカスタマイズして、任意のデータ群のみをoverlay

% %% loop回すべき全ファイルを取得
% files = dir(sprintf('measurement_conditions/%s/*.mat', DATE)); 
% filename_array = string({files.name});

%% 各測定条件についてloopして相関関数をoverlayしていく
for idx=1:length(filename_array)
    
    clearvars -except filename_array DATE idx
    filename = filename_array(idx);
    
    %%測定データをload
    %全部の位置
     load(sprintf("workspace/%s/temporal_%s", DATE, filename),'COR','TAU','sample_name','modelfun','parms')
    %定点
     %load(sprintf("workspace/%s/X_temporal_%s", DATE, filename),'COR','TAU','sample_name')
    
%     %フィット後
%     COR = modelfun(parms,TAU);
    %規格化して１ < COR_normalized <２にする
    COR_normalized = COR-1;
    COR_normalized = (COR_normalized ./ COR_normalized(1)) + 1; 
    
    %フィットしていない相関関数をplot
    txt = [sample_name];
    semilogx(TAU, COR_normalized,'-o', 'DisplayName',txt)
    
    hold on;
end

%% loop終了後、Figに説明をつける
ax = gca; % current axes
ax.FontSize = 12;
% xlabel("lagtime (s)", 'FontSize',14,'FontWeight','bold');
% ylabel("Correlation Normalized", 'FontSize',14,'FontWeight','bold');
xlabel("ずれ時間 (s)", 'FontSize',14,'FontWeight','bold');
ylabel("規格化した相関関数", 'FontSize',12,'FontWeight','bold');

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