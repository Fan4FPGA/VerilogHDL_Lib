function img_pic = GetImgFromTxt(ImgTxt_File_Name, Col, Row, Threshold, OutImgFile_Name);

% Get image from a txt file that Verilog output
% 图像宽度为Col，图像高度为Row，由Verilog输出的第一行和最后一行缺失（应该填写零）

fid = fopen(ImgTxt_File_Name, 'r');

img = fscanf(fid,'%x',[Col Row-2]);
img = img';
figure('Name', '亮度导数图'), imshow(img)

for row = 1:Row
    for col = 1:Col
        if (row == 1 | row == Row)
            img_pic(row, col) = uint8(0);
        elseif (img(row-1, col) > Threshold)
            img_pic(row, col) = uint8(255);
        else
            img_pic(row, col) = uint8(0);
        end
     end
end
        
figure('Name', '图像边缘'), imshow(img_pic)
imwrite(img_pic, OutImgFile_Name, 'bmp');

fclose(fid);




