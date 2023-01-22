%% filename_arrayをカスタマイズして、任意のデータ群のみをoverlay

% %% loop回すべき全ファイルを取得
% files = dir(sprintf('measurement_conditions/%s/*.mat', DATE)); 
% filename_array = string({files.name});

%% 各測定条件についてloopして相関関数をoverlayしていく
for idx=1:length(filename_array)
    clearvars -except filename_array DATE idx
    filename = filename_array(idx);
    
    %測定データをload
    load(sprintf("workspace/%s/temporal_%s", DATE, filename),'COR','TAU','sample_name')
    
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
xlabel("lagtime (s)", 'FontSize',14,'FontWeight','bold');
ylabel("Correlation Normalized", 'FontSize',14,'FontWeight','bold');

hold off

%% Legend (https://jp.mathworks.com/help/matlab/ref/matlab.graphics.illustration.legend-properties.html)
lgd = legend;
% lgd.FontSize = 14;
%lgd.Location = 'northoutside';
lgd.Location = 'bestoutside';