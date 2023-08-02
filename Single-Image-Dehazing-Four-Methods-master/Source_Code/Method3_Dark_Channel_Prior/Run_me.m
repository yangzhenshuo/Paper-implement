%% ³���Բ��ԡ��������ݲ�İ�ͨ������ȥ���㷨

tic
%% ��һ�� ��ȡͼ�񣬻�óߴ�Ļ�����Ϣ
%���
clear;     
clc;       
for image_number=1:8
    imageName=strcat(num2str(image_number),'.jpg');
    I = imread(imageName);
    figure;
    imshow(I,[]);
    title(['��',num2str(image_number),'��ͼ���ԭͼ']);

    % ��ȡͼ���С��ά��
    [height,width,dimention] = size(I);

    %% �ڶ��� ��ȡ��ͨ��ͼ��

    % ��Сֵ�˲����ڴ�СΪ 15 = 7*2+1
    window_size = 7;
    % ����My_darkchannel����
    dark_channel =  My_darkchannel(I,window_size);
    dark_channel = dark_channel./255;

    %% ������ ���������ɷ�A
    % AΪ1*1*3�ľ��󣬼���ȡ����RGB�������ճɷ�
    I = im2double(I);
    % ����My_estimateA����
    A = My_estimateA(I,dark_channel);

    %% ����͸���ʾ���t(x)
    % ȥ����ȫϵ����w = 1��ȫȥ��
    w = 0.95;

    % �ð�ͨ������͸����  
    t = 1-w*dark_channel/mean(A(1,1,:));

    % ��ȡ�Ҷ�ͼƬ
    I_gray = rgb2gray(I);

    % �õ����˲���t�����Ż�
    % ����My_guidedfilter�������ͼ�Ż�͸���ʾ���
    t1 = My_guidedfilter(I_gray, t, 135, 0.0002);

    % �õ����˲���Ͷ���ʾ���
    % ���б���Եģ��
    t2 = My_guidedfilter(t1,t1,7,0.03);

    % ͸��ͼ��ֵ����ֹͶ��ͼ��С��ʱ��ͼ������ֵ����
    t_treshold = 0.1;
    % ȡt0=0.1��ֹ������׳����ȣ�С��0.1��ֵȡ0.1

    t = max(t2,t_treshold);


    %% ���Ĳ� �ָ�����ͼ��

    % �����ݲ�
    K = 0.2;
    % ��ʼ��ȥ��ͼ��
    defog_image = zeros(size(I));

    % �øĽ���ʽ������ͨ������ȥ��
    defog_image(:,:,1) = ((I(:,:,1)-A(1,1,1))...
                            ./min(1,t.*max( K./abs(I(:,:,1)-A(1,1,1)),1) ...
                            )) +A(1,1,1);
    defog_image(:,:,2) = ((I(:,:,2)-A(1,1,2))...
                            ./min(1,t.*max( K./abs(I(:,:,2)-A(1,1,2)),1) ...
                            )) +A(1,1,2);

    defog_image(:,:,3) = ((I(:,:,3)-A(1,1,3))...
                            ./min(1, t.*max( K./abs(I(:,:,3)-A(1,1,3)),1) ...
                            )) +A(1,1,3);


    % dark channel prior������ʹͼƬ�䰵
    % ��ϵ��ʹ��ͼƬ��
    defog_image = defog_image*1.3;

    %% ���岽 �������ͼ��
    figure;
    imshow(defog_image);
    title(['��',num2str(image_number),'��ͼ���ȥ��ͼ��']);
    clear;     
    clc;     
end
    toc

