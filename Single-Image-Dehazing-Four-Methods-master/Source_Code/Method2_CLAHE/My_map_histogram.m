%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   My_adapthisteq�������ط����look_up_table����Χ��min_pixel��
%                   max_pixel
%   ���룺����ֱ��ͼHist  
%         �Ҷ�ֵ������min_pixel,max_pixel
%         ���ص����� 
%         ֱ��ͼ��������sum_pixel_bin
%         �߷ֳɵ��ӿ���subpart_X  
%         ��ֳɵ��ӿ���subpart_Y
%   ������ط����look_up_tabl
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [output] = My_map_histogram(Hist,min_pixel,max_pixel,sum_pixel_bins,sum_pixels,subpart_X,subpart_Y)
    output=zeros(subpart_X,subpart_Y,sum_pixel_bins);
    scale = (max_pixel - min_pixel)/sum_pixels;
    % ��������
    for i = 1:subpart_X
        for j = 1:subpart_Y
            sum = 0;
            for nr = 1:sum_pixel_bins
                sum = sum + Hist(i,j,nr);
                output(i,j,nr) = fix( min( min_pixel + sum*scale,max_pixel ) );
            end
        end
    end
end

