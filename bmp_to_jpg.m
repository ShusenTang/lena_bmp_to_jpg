%
%  bmp_to_jpg.m
%
%  Created by  唐树森 on 2017/4/24.
%  Copyright ? 2017年 shusen tang. All rights reserved.
%
%  问题：用JPEG、JPEG2000压缩lena512*512灰度图像(码率0.3bpp)；比较压缩质量(PSNR)
%
%  结论：在相同码率(0.31),也即压缩后图片大小(约81800Bytes)相同的情况下，
%       JPEG2000压缩后的图像PSNR(50.74)要略大于JPEG压缩后的PSNR(45.90)，因此JPEG2000压缩失真小


close all;
clear;
clc;
original_image = imread('lena512.bmp');
imwrite(original_image,'lena512.jpg','jpg','Quality', 94);%bmp格式转换为jpg格式,不断Quality的值使得bpp为0.3左右
imwrite(original_image,'lena512.jp2','jp2','CompressionRatio',3.18);%bmp格式转换为jp2格式

jpeg_image = imread('lena512.jpg');
jpeg2000_image = imread('lena512.jp2');

imshow(original_image); title('原始图像');
figure;
subplot(1,2,1);
imshow(jpeg_image); title('JPEG图像');
subplot(1,2,2);
imshow(jpeg2000_image); title('JPEG2000图像');

%图片信息存储在info变量中，是个结构体
original_info = imfinfo('lena512.bmp');
jpeg_info = imfinfo('lena512.jpg');
jpeg2000_info = imfinfo('lena512.jp2');

%数据量
jpeg_original_bytes = original_info.FileSize;
jpeg_compressed_bytes = jpeg_info.FileSize;
jpeg2000_compressed_bytes = jpeg2000_info.FileSize;

%计算bpp
jpeg_compression_bpp = jpeg_compressed_bytes / jpeg_original_bytes;
jpeg2000_compression_bpp =  jpeg2000_compressed_bytes / jpeg_original_bytes;

%计算PSNR峰值信噪比,PSNR越高，压缩后失真越小。
max = 255;%灰度级
[h,w] = size(original_image);%h=w=512

jpeg_MES=sum(sum((original_image-jpeg_image).^2))/(h*w);%jpeg均方差
jpeg_PSNR=20*log10(max/sqrt(jpeg_MES));           %jpeg峰值信噪比

jpeg2000_MES=sum(sum((original_image-jpeg2000_image).^2))/(h*w);%jpeg2000均方差
jpeg2000_PSNR=20*log10(max/sqrt(jpeg2000_MES));           %jpeg2000峰值信噪比
