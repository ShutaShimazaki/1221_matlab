function [KSAI, COR] = spatial_correlation(XT, X_SCALE, T)
% ������TAU(�萔)�ɑ΂��āAC(ksai, TAU)���v�Z���K�؂ȃv���b�g���o�͂���B
%F(x, t) 
    %C(ksai=1, TAU) = F(1,1)*F(2, 1+TAU) + F(1,2)*F(2,
    %2+TAU)+//+F(x,t)*F(x+ksai, t+TAU)+//+F(PIXEL, TIME_SERIES)*F(PIXEL+ksai,
    %TIME_SERIES+TAU) ��COR(1)
    %C(ksai=2, TAU)
    %C(ksai_max=, TAU)

%% �ϐ��錾
TIME_SERIES = size(XT,1); %1000
NUMBER_KSAI = size(XT,2); %KSAI_MAX = PIXEL��
MIN_KSAI = -round(NUMBER_KSAI/2);
MAX_KSAI = MIN_KSAI+NUMBER_KSAI-1;
%% ���O���蓖��
KSAI = zeros(1,NUMBER_KSAI);
COR = zeros(1,NUMBER_KSAI); % �i�т̌��j
%% ACF
idx_ksai = 1;
for ksai = MIN_KSAI: MAX_KSAI
    count = 0;
    tmpCOR = 0;
    %�^���摜���̃}�X�̔C�ӂ̂P�s�it = T)�ɂ��āAF(x,T) * F(x+ksai, T)���s��
    for x = 1 : NUMBER_KSAI
        for t = 1:TIME_SERIES %1000
            if (x+ksai > NUMBER_KSAI) ||(x + ksai < 1) || (T > TIME_SERIES)
                break
            end
            tmpCOR = XT(T,x) * XT(T, x+ksai) + tmpCOR;
            count = count + 1;
        end
    end
    KSAI(idx_ksai) = X_SCALE * ksai;
    COR(idx_ksai) = tmpCOR /count;
    idx_ksai = idx_ksai + 1;    
end
    
%% T�s�ڂ̕��όu�����x�̂Q�� F(x,t)^2�ŋK�i��
average_F2 = mean(XT(T, :),'all')^2;
COR = COR./average_F2;

end


