%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   My_guidedfilter�������˲����Ż�Ͷ���ʾ���
%   ���룺
%       guide_image����ͼƬ
%       I���˲�ͼƬ
%       radius���˲��뾶
%       sooth_parameter��ƽ���̶�
%   �����output���Ż���Ͷ���ʾ���
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [output] = My_guidedfilter(guide_image, I, radius, sooth_parameter)


    [height, width] = size(guide_image);
    % Ͷ���ʾ����а뾶radius���ۻ��ͣ�������ƽ��
    N = My_cumulative_sum(ones(height, width), radius); 
    
    % ��ͼ��ƽ��
    mean_guide = My_cumulative_sum(guide_image, radius) ./ N;
    % �˲�ͼ��ƽ��
    mean_I = My_cumulative_sum(I, radius) ./ N;
    % ������ͼ���˲�ͼ�Ļ���ƽ��
    mean_IG = My_cumulative_sum(guide_image.*I, radius) ./ N;
    % ������ͼ���˲�ͼ��Э����
    cov_IG = mean_IG - mean_guide .* mean_I;
    % ������ͼƽ����ƽ��
    mean_II = My_cumulative_sum(guide_image.*guide_image, radius) ./ N;
    % �����˲�ͼƬ�ķ���
    var_I = mean_II - mean_guide .* mean_guide;
    
    % ��a
    a = cov_IG ./ (var_I + sooth_parameter);
    % ��b
    b = mean_I - a .* mean_guide; 
    
    % ��a��ƽ��
    mean_a = My_cumulative_sum(a, radius) ./ N;
    % ��b��ƽ��
    mean_b = My_cumulative_sum(b, radius) ./ N;
    
    % ��q
    q = mean_a .* guide_image + mean_b; 
    output = q;
end