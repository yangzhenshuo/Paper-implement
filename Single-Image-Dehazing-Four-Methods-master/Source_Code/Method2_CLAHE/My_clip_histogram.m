%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   My_adapthisteq�����ú��������ڼ���ֱ��ͼ�������·�������ֵ,
%                   ���԰ѳ���Clip_limit������ֵ���ȷ��䵽ֱ��ͼ
%                    ������λ��
%   ���룺����ֱ��ͼHist
%         ֱ��ͼ��������sum_pixel_bin
%         ������ֵClip_limit
%         �߷ֳɵ��ӿ���subpart_X  
%         ��ֳɵ��ӿ���subpart_Y
%   ��������ú��ֱ��ͼHist
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [Hist] = My_clip_histogram(Hist,sum_pixel_bin,clip_limit,subpart_X,subpart_Y)
    
    for i = 1:subpart_X
        for j = 1:subpart_Y
           %% ��һ�� ���㳬����ֵ������ֵ���� 
            sum_excess = 0;
            for nr = 1:sum_pixel_bin
                excess = Hist(i,j,nr) - clip_limit;
                if excess > 0
                    sum_excess = sum_excess + excess;
                end
            end

           %% �ڶ��� ���ò��ؽ�ֱ��ͼ
            % ƽ������������ֵ
            bin_averate = sum_excess / sum_pixel_bin;
            % ���ޣ���֤�ؽ���ֱ��ͼ��������ֵ
            upper = clip_limit - bin_averate;
            for nr = 1:sum_pixel_bin
                % ��������ֵ��ֱ�Ӳõ�
                if Hist(i,j,nr) > clip_limit
                    Hist(i,j,nr) = clip_limit;
                else
                    % �������������ޣ�����Щ����ֵ��Ϊ��ֵ
                    if Hist(i,j,nr) > upper
                        % �������м�ȥ
                        sum_excess = sum_excess + upper - Hist(i,j,nr);
                        Hist(i,j,nr) = clip_limit;
                    else
                        % ������С�����ޣ������ƽ������������ֵ
                        sum_excess = sum_excess - bin_averate;
                        Hist(i,j,nr) = Hist(i,j,nr) + bin_averate;
                    end
                end
            end
            
            % ����������ֵ���������㣬��ƽ���ָ�ÿһ������ֵ
            if sum_excess > 0
                % ���㲽��
                step_size = max(1,fix(1+sum_excess/sum_pixel_bin));
                % ����С�Ҷȼ������Ҷȼ����ղ���ѭ������
                for nr = 1:sum_pixel_bin
                    sum_excess = sum_excess - step_size;
                    Hist(i,j,nr) = Hist(i,j,nr) + step_size;
                    % ��С��1��ѭ������
                    if sum_excess < 1
                        break;
                    end
                end
            end
            
        end
    end
end
