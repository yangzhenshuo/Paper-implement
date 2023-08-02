%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    My_minfilter����Сֵ�˲�
%   ���룺
%       I������Ҷ�ͼ��
%       window_size����Сֵ�˲��Ĵ��ڴ�С
%   �����output����Сֵ�˲��İ�ͨ��ͼ��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [output] = My_minfilter(I,window_size)

    %% ��һ�� ��ȡͼ����Ϣ
    I_new = I;
    [height,width] = size(I);
    
    %% �ڶ��� ����ѭ����������Сֵ��
    for i = 1:height
        for j = 1:width
            % ����߽磬��ֹԽ��
            i_down = i-window_size;
            i_up = i+window_size;
            j_down = j-window_size;
            j_up = j+window_size;
            if(i_down<=0)
                i_down = 1;
            end
            if(j_down<=0)
                j_down = 1;
            end
            if(i_up>height)
                i_up = height;
            end
            if(j_up>width)
                j_up = width;
            end
            % ��Сֵ�˲���ȡ�����ڵ���Сֵ��Ϊ��ǰ���ص��ֵ
            I_new(i,j) =  min (min(I(i_down:i_up,j_down:j_up)) );
        end
    end
    
    %% ������ ���
    output = I_new;
end