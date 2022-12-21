function [TAU, COR] = temporal_correlation(XT, TIME_SCALE, X)
%��_(X)�ɂ����鎞�ԑ��ւ����߂�
%% �ϐ��錾
TIME_SERIES = size(XT,1); %1000
PIXEL = size(XT,2); %32
TAU_MAX = 100; %TAU�̌� = PIXEL���փ_�E���T���v�����O
%% ���O���蓖��
TAU = zeros(1,TAU_MAX);
TAU_BETWEEN = round(logspace(0, 2, TAU_MAX)); %�ΐ��I�ɓ��Ԋu��TAU_MAX�̓_�𐶐��B
COR = zeros(1,TAU_MAX); % �i�т̌��j
%% ACF (multiple tau)
for tau = 1: TAU_MAX
    count = 0;
    tmpCOR = 0;
    %�^���摜���̔C�ӂ̂P��(x = X)�ɂ��āAF(X,t) * F(X, t+tau)���s��
    
    for t = 1:TIME_SERIES %1000
        if (X > PIXEL) || (t+ TAU_BETWEEN(tau) > TIME_SERIES)
            break
        end
        tmpCOR = XT(t,X) * XT(t+TAU_BETWEEN(tau), X) + tmpCOR;
        count = count + 1;
    end
    COR(tau) = tmpCOR /count;
    TAU(tau) = TIME_SCALE * TAU_BETWEEN(tau);
end
           
%% X��ڂ̕��όu�����x�̂Q�� F(x,t)^2�ŋK�i��
average_F2 = mean(XT(:, X),'all')^2;
COR = COR./average_F2;

end


