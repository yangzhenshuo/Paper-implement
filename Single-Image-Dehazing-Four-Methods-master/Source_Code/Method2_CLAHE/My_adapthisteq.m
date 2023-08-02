%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   My_adapthisteq�����ƶԱȶȵ�����Ӧֱ��ͼ�㷨
%   ���룺�Ҷ�ͼI_gray
%   ��������⻯��ĻҶ�ͼoutput
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [output] = My_adapthisteq(I_gray)
    %% ��һ�� ��ȡͼƬ������Ϣ
    [height,width] = size(I_gray);  
    % ��ȡ�����С����
    min_pixel = double(min(min(I_gray)));  
    max_pixel = double(max(max(I_gray)));  
    
    %% �ڶ��� ��ͼƬ���зֿ�
    % |-------Y
    % |
    % |
    % X
    % ���ݾ��鰴��ͼƬ�ߴ�ֳ����ɸ��ӿ�
    % Y��Ϊ��width/100-2�����ӿ�
    subpart_Y = floor(width/100)-2;  
    % X��Ϊ��height/100-1�����ӿ�
    subpart_X = floor(height/100)-1;  
    % �ӿ�Ŀ�͸�
    height_size = ceil(height/subpart_X);  
    width_size = ceil(width/subpart_Y);  
    
    % ���ܱ�֤��������Ҫ����  
    delta_y = subpart_X*height_size - height;  
    delta_x = subpart_Y*width_size - width;  
    
    % ����
    temp_Image = zeros(height+delta_y,width+delta_x);  
    temp_Image(1:height,1:width) = I_gray;  
    
    % �µĸߺͿ�
    new_width = width + delta_x;  
    new_height = height + delta_y;  
    % ���ص�����  
    sum_pixels = width_size * width_size; 
    
    %% ������ ����Look-up-table
    % ��������������������ֱ��ͼ����ļ��
    sum_pixel_bins = 256;
    % ����Look-Up-Table
    look_up_table = zeros(max_pixel+1,1);  
    
    % ͨ������ĻҶ�ֵ��Χ����ӳ��
    for i = min_pixel:max_pixel  
        look_up_table(i+1) = fix(i - min_pixel);  
    end  
    
    %% ���Ĳ� Ϊÿ���ӿ齨��ֱ��ͼ
    % ��һ������ͼ�ĻҶ�ֵ
    % ʹ��Look-up-table
    pixel_bin = zeros(new_height, new_width);  
    for m = 1 : new_height  
        for n = 1 : new_width  
            pixel_bin(m,n) = 1 + look_up_table(temp_Image(m,n) + 1);  
        end  
    end  
    
    % HistΪ����256��4*8���������洢ֱ��ͼ
    % 4*8��ʾ���ֳ���4*8���ӿ飬256��ʾ�Ҷȼ�
    % Hist(x,y,i)��ʾ
    % ���ڻ��ֵ�����Ϊ(x,y)���ӿ��У�����ֵ=i�����ص㣩������
    Hist = zeros(subpart_X, subpart_Y, 256);  
    for i=1:subpart_X  
        for j=1:subpart_Y  
            % Ϊÿ���ӿ齨��ֱ��ͼ
            tmp = uint8(pixel_bin(1+(i-1)*height_size:i*height_size, 1+(j-1)*width_size:j*width_size));  
            [Hist(i, j, :), x] = imhist(tmp, 256);  
        end  
    end  
    % �����Ҷ�ֵ����һά  
    Hist = circshift(Hist,[0, 0, -1]);  
    
    %% ���岽 ����ֱ��ͼ 
    % ���ò���
    clip_limit = 2.5;  
    clip_limit = max(1,clip_limit * height_size * width_size/sum_pixel_bins);  
    
    % ���ü��ú���
    Hist = My_clip_histogram(Hist,sum_pixel_bins,clip_limit,subpart_X,subpart_Y);  
    
    %% ������ �Ҷ�ֵӳ������Բ�ֵ����
    Map = My_map_histogram(Hist, min_pixel, max_pixel, sum_pixel_bins, sum_pixels, subpart_X, subpart_Y);  
    y_I = 1;  
    for i = 1:subpart_X+1  
        % ��������߽�
        if i == 1  
            sub_Y = floor(height_size/2);  
            y_Up = 1;  
            y_Bottom = 1;  
        elseif i == subpart_X+1  
            sub_Y = floor(height_size/2);  
            y_Up = subpart_X;  
            y_Bottom = subpart_X;  
        % �������ڲ�
        else  
            sub_Y = height_size;  
            y_Up = i - 1;  
            y_Bottom = i;  
        end  
        xI = 1;  
        % ��������߽�
        for j = 1:subpart_Y+1  
            if j == 1  
                sub_X = floor(width_size/2);  
                x_Left = 1;  
                x_Right = 1;  
            elseif j == subpart_Y+1  
                sub_X = floor(width_size/2);  
                x_Left = subpart_Y;  
                x_Right = subpart_Y;
            % �������ڲ�
            else  
                sub_X = width_size;  
                x_Left = j - 1;  
                x_Right = j;  
            end  
            % ���лҶ�ֵӳ��
            U_L = Map(y_Up,x_Left,:);  
            U_R = Map(y_Up,x_Right,:);  
            B_L = Map(y_Bottom,x_Left,:);  
            B_R = Map(y_Bottom,x_Right,:);  
            sub_Image = pixel_bin(y_I:y_I+sub_Y-1,xI:xI+sub_X-1);  
      
            % ���Բ�ֵ���� 
            s_Image = zeros(size(sub_Image));  
            num = sub_Y * sub_X;  
            for m = 0:sub_Y - 1  
                inverse_I = sub_Y - m;  
                for n = 0:sub_X - 1  
                    inverse_J = sub_X - n;  
                    val = sub_Image(m+1,n+1);  
                    s_Image(m+1, n+1) = (inverse_I*(inverse_J*U_L(val) + n*U_R(val)) ...  
                                    + m*(inverse_J*B_L(val) + n*B_R(val)))/num;  
                end  
            end     
            output(y_I:y_I+sub_Y-1, xI:xI+sub_X-1) = s_Image;  
            xI = xI + sub_X;  
        end  
        y_I = y_I + sub_Y;  
    end  
    
    %% ���߲� ����ǲ���Ĳ���
    output = output(1:height, 1:width);  
end