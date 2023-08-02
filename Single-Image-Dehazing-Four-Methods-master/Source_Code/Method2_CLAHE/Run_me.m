%% ³���Բ��ԡ������ھֲ��Աȶ���ǿ��CLAHE�㷨
tic

%% ��չ����������
clc;
clear;
for image_number=1:8
    imageName=strcat(num2str(image_number),'.jpg');
    img = imread(imageName);
    figure;
    imshow(img);
    title(['��',num2str(image_number),'��ͼ���ԭͼ']);

    %% ��LAB�ռ����ȥ��

    % RGBתLAB
    transform = makecform('srgb2lab');  
    LAB = applycform(img,transform);  

    % ��ȡ���ȷ��� L
    L = LAB(:,:,1); 

    % ��L����CLAHE
    LAB(:,:,1) = My_adapthisteq(L);
    % ��Сһ��������
    LAB(:,:,1) = LAB(:,:,1)-50;

    %% ת�ص�RGB�ռ�
    cform2srgb = makecform('lab2srgb');  
    J = applycform(LAB, cform2srgb);

    %% ���ͼ��
    figure;
    J = 1.35.*J;
    imshow(J);  
    title(['��',num2str(image_number),'��ͼ���ȥ��ͼ��']);
    clc;
    clear;
end
    toc