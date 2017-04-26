%
%  bmp_to_jpg.m
%
%  Created by  ����ɭ on 2017/4/24.
%  Copyright ? 2017�� shusen tang. All rights reserved.
%
%  ���⣺��JPEG��JPEG2000ѹ��lena512*512�Ҷ�ͼ��(����0.3bpp)���Ƚ�ѹ������(PSNR)
%
%  ���ۣ�����ͬ����(0.31),Ҳ��ѹ����ͼƬ��С(Լ81800Bytes)��ͬ������£�
%       JPEG2000ѹ�����ͼ��PSNR(50.74)Ҫ�Դ���JPEGѹ�����PSNR(45.90)�����JPEG2000ѹ��ʧ��С


close all;
clear;
clc;
original_image = imread('lena512.bmp');
imwrite(original_image,'lena512.jpg','jpg','Quality', 94);%bmp��ʽת��Ϊjpg��ʽ,����Quality��ֵʹ��bppΪ0.3����
imwrite(original_image,'lena512.jp2','jp2','CompressionRatio',3.18);%bmp��ʽת��Ϊjp2��ʽ

jpeg_image = imread('lena512.jpg');
jpeg2000_image = imread('lena512.jp2');

imshow(original_image); title('ԭʼͼ��');
figure;
subplot(1,2,1);
imshow(jpeg_image); title('JPEGͼ��');
subplot(1,2,2);
imshow(jpeg2000_image); title('JPEG2000ͼ��');

%ͼƬ��Ϣ�洢��info�����У��Ǹ��ṹ��
original_info = imfinfo('lena512.bmp');
jpeg_info = imfinfo('lena512.jpg');
jpeg2000_info = imfinfo('lena512.jp2');

%������
jpeg_original_bytes = original_info.FileSize;
jpeg_compressed_bytes = jpeg_info.FileSize;
jpeg2000_compressed_bytes = jpeg2000_info.FileSize;

%����bpp
jpeg_compression_bpp = jpeg_compressed_bytes / jpeg_original_bytes;
jpeg2000_compression_bpp =  jpeg2000_compressed_bytes / jpeg_original_bytes;

%����PSNR��ֵ�����,PSNRԽ�ߣ�ѹ����ʧ��ԽС��
max = 255;%�Ҷȼ�
[h,w] = size(original_image);%h=w=512

jpeg_MES=sum(sum((original_image-jpeg_image).^2))/(h*w);%jpeg������
jpeg_PSNR=20*log10(max/sqrt(jpeg_MES));           %jpeg��ֵ�����

jpeg2000_MES=sum(sum((original_image-jpeg2000_image).^2))/(h*w);%jpeg2000������
jpeg2000_PSNR=20*log10(max/sqrt(jpeg2000_MES));           %jpeg2000��ֵ�����
