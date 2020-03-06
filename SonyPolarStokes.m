%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        Sony Color Polarization Stokes Process            %
%                                                          %
%    Copyright (C) 2020 Liu Xiao. All rights reserved.     %
%                    liux@aiofm.ac.cn                      %
%                                                          %
%  SonyPolarImageCrop: Stokes Images from Sony Polar Sensor%
%                                                          %
%  Input Parameters:                                       %
%  Image1: Image 090degree                                 %
%  Image2: Image 045degree                                 %
%  Image3: Image 000degree                                 %
%  Image4: Image 135degree                                 %
%  Start_X: Valid Image X Axis                             %
%  Start_Y: Valid Image Y Axis                             %
%  Size_X: Valid Image X Size                              %
%  Size_Y: Valid Image Y Size                              %
%  ImgReg: 1=Run ImageRegistration,0=None ImageRegistration%
%                                                          %
%  Output Parameters:                                      %
%  S0: Image Stokes S0                                     %
%  S1: Image Stokes S1                                     %
%  S2: Image Stokes S2                                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [S0,S1,S2]=SonyPolarStokes(Image1,Image2,Image3,Image4,Start_X,Start_Y,Size_X,Size_Y,ImgReg)

if Size_X==0&&Size_Y==0&&Start_X==0&&Start_Y==0
    Image1_TEMP = double(Image1);
    Image2_TEMP = double(Image2);
    Image3_TEMP = double(Image3);
    Image4_TEMP = double(Image4);
else
    Image1_TEMP = double(imcrop(Image1,[Start_X,Start_Y,Size_X,Size_Y]));
    Image2_TEMP = double(imcrop(Image2,[Start_X,Start_Y,Size_X,Size_Y]));
    Image3_TEMP = double(imcrop(Image3,[Start_X,Start_Y,Size_X,Size_Y]));
    Image4_TEMP = double(imcrop(Image4,[Start_X,Start_Y,Size_X,Size_Y]));
end

% 如果需要配准，以Image1_TEMP为基准
if ImgReg == 1
    Image2_TEMP = ImageRegistration(Image1_TEMP,Image2_TEMP);
    Image3_TEMP = ImageRegistration(Image1_TEMP,Image3_TEMP);
    Image4_TEMP = ImageRegistration(Image1_TEMP,Image4_TEMP);
end

S0 = (Image1_TEMP+Image2_TEMP+Image3_TEMP+Image4_TEMP)/2;
S1 = Image3_TEMP - Image1_TEMP;
S2 = Image2_TEMP - Image4_TEMP;
