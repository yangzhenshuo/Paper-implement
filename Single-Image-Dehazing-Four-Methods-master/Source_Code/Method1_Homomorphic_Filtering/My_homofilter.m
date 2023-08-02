%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   My_homofilter��̬ͬ�˲��㷨
%   ���룺�Ҷ�ͼI_mean
%   �����̬ͬ�˲���ĻҶ�ͼoutput
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [output] = My_homofilter(I_mean)
    %% ��һ�� ȡ���������и���Ҷ�任
    I_log = log(I_mean+1);
    % ����Ҷ�任
    I_fft = fft2(I_log);
    I_fft = fftshift(I_fft);

    %% �ڶ��� Ƶ���˹��ͨ�˲�
    
    % ��˹�˲����Ĳ���
    L = 0.3;
    H = 1.8;
    C = 2;
    % ��ֹƵ��D0
    D0 = 1;

    % ����mask
    [height,width] = size(I_mean);
    mask = zeros(height,width);
    for i=1:height
        for j=1:width
            % ���ݾ������ĵľ�����
            D = sqrt(((i-height/2)^2+(j-width/2)^2));
            mask(i,j) = (H-L)*(1-exp(C*(-D/(D0))))+L; %��˹̬ͬ�˲�
        end
    end
%     % ��ʾmask��ͼ��
%     figure;
%     imshow(mask,[]);   
%     title('mask��ͼ��');

    % ��mask���е��
    I_fft_gauss = mask.*I_fft;
    
    %% ������ ����Ҷ��任��ȡָ��
    I_fft_gauss = ifftshift(I_fft_gauss);
    
    I_ifft = ifft2(I_fft_gauss);
    % ȡָ�����ָ�ԭͼ
    I_gray_defog = real(exp(I_ifft)+1);
    
    output = I_gray_defog;
end