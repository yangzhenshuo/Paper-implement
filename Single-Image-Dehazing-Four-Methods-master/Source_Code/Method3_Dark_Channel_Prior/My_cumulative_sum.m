%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    Cumulative_sum������ָ���뾶���ۻ���
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Cumulative_sum = My_cumulative_sum(input, r)

    % output(x, y)=sum(sum(imSrc(x-r:x+r,y-r:y+r)));
    % ��colfilt(imSrc, [2*r+1, 2*r+1], 'sliding', @sum)����ʵ��һ���Ĺ��ܣ������ٶȷǳ���;
   

    [height, width] = size(input);
    Cumulative_sum = zeros(size(input));

    % �����е��ۻ���
    cumulative = cumsum(input, 1);
    % �����еĵ���
    Cumulative_sum(1:r+1, :) = cumulative(1+r:2*r+1, :);
    Cumulative_sum(r+2:height-r, :) = cumulative(2*r+2:height, :) - cumulative(1:height-2*r-1, :);
    Cumulative_sum(height-r+1:height, :) = repmat(cumulative(height, :), [r, 1]) ...
                                            - cumulative(height-2*r:height-r-1, :);

    % �����е��ۻ���
    cumulative = cumsum(Cumulative_sum, 2);
    % �����еĵ���
    Cumulative_sum(:, 1:r+1) = cumulative(:, 1+r:2*r+1);
    Cumulative_sum(:, r+2:width-r) = cumulative(:, 2*r+2:width) - cumulative(:, 1:width-2*r-1);
    Cumulative_sum(:, width-r+1:width) = repmat(cumulative(:, width), [1, r])...
                                            - cumulative(:, width-2*r:width-r-1);
end

