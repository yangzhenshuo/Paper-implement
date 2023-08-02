%% ³���Բ��ԡ�������̬ͬ�˲���ȥ���㷨

tic
%% ��չ����������
clc;
clear;
for image_number=1:8
    imageName=strcat(num2str(image_number),'.jpg');
    I = imread(imageName);
    figure;
    imshow(I);
    title(['��',num2str(image_number),'��ͼ���ԭͼ']);

    %% ����̬ͬ�˲�
    % ȡ����ͨ����ƽ���Ҷ���Ϊ����
    I_mean = mean(I,3);
    % ȥdouble�����������
    I_mean = im2double(I_mean);

    % ����̬ͬ�˲�����
    I_gray_defog = My_homofilter(I_mean);

    % ��һ����[0,1]
    max_pixel = max(max(I_gray_defog));
    I_gray_defog = mat2gray(I_gray_defog,[0,max_pixel]);

    %% ����̬ͬ�˲����ƽ���Ҷ���ӳ��
    % ������ͨ��
    I_defog = zeros(size(I));
    for i = 1:3
        % ��ȥ���ƽ���Ҷ���ӳ��
        I_defog(:,:,i) = (double(I(:,:,i)).*I_gray_defog)./I_mean ;
    end

    % ��һ����[0,1]
    max_pixel = max( max( max(I_defog) ) );
    min_pixel = min( min( min(I_defog) ) );
    I_defog = mat2gray(I_defog,[min_pixel,max_pixel]);
    % ��������
    I_defog = 1.35.*I_defog;

    %% ���ͼ��
    figure;
    imshow(I_defog,[]);
    title(['��',num2str(image_number),'��ͼ���ȥ��ͼ��']);
    clc;
    clear;
end
toc
