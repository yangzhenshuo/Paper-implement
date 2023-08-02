%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    My_darkchannel����ͨ��
%   ���룺
%       I������RGBͼ��
%       window_size����ͨ����Сֵ�˲��Ĵ��ڴ�С
%   �����output����ͨ��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [output] = My_darkchannel(I,window_size)

    %% ��һ�� ��ȡͼ����Ϣ
	% ��ȡͼ���С��ά��
    [height,width,~] = size(I);
    % ��ʼ����ͨ��ͼ��
    dark_channel = ones(height,width);
    
    %% �ڶ��� ��ȡÿ�����ص�����ͨ������Сֵ
    for i = 1:height
        for j = 1:width
            % ��ȡ���ص�λ������ͨ������Сֵ
            dark_channel(i,j) = min( I(i,j,:) );
 
        end
    end 
    
    %% ������ ��Сֵ�˲�
    % ����My_minfilter����������Сֵ�˲�
    min_dark_channel = My_minfilter(dark_channel,window_size);
    
    %% ���Ĳ� �����ͨ��
    output = min_dark_channel;
    
end