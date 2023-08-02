%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    My_estimateA������ȫ�ִ�����A
%   ���룺
%       I������RGBͼ��
%       dark_channel��I�İ�ͨ��
%   �����output��RGB����ͨ����ȫ�ִ�����A
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [output] = My_estimateA(I,dark_channel)
    
    %% ��һ�� ��ʼ��A����ȡ��Ϣ
    A = zeros(1,1,3);
    [height,width] = size(dark_channel);
    
   
    
    % һ��Ҫȡ�ĵ����������ֵǰ0.1%һ������)
    points_number = round(width * height * 0.001);
    % ������������м���A��ֵ
    % ���㿪ʼ����
    for k = 1:points_number    
        
         %% �ڶ��� ȡ��dark_channel�������
        brightest_points = max( max(dark_channel) );
        [i,j] = find (dark_channel==brightest_points);
        % �����ж�������㣬ȡ��һ������
        i = i(1);
        j = j(1);
        % ������������0��������Ѱ�ڶ����ĵ�
        dark_channel(i,j) = 0;
        
         %% ������ ���������λ�ü���Aֵ
        % ��ԭͼ�ж�Ӧλ���ҵ���������ֵ
        % ������ͨ��ȡƽ��
        % ������A�������A��ֵ
        if(mean( I(i,j,:) )>mean(A(1,1,:)))
            % �ֱ��¼����ͨ����Aֵ
            A(1,1,1) = (A(1,1,1)+I(i,j,1))/2;
            A(1,1,2) = (A(1,1,2)+I(i,j,2))/2;
            A(1,1,3) = (A(1,1,3)+I(i,j,3))/2;
        end
    end
    
    %% ���Ĳ� ���A
    output = A;
end