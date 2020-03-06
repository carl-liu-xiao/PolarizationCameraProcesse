%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        Sony Color Polarization Image Process             %
%                                                          %
%    Copyright (C) 2020 Liu Xiao. All rights reserved.     %
%                    liux@aiofm.ac.cn                      %
%                                                          %
%  SonyPolarImageCrop: Split image with different          %
%    polarization angle and different wavelengt.           %
%  I1: Raw Polarization Image                              %
%  IR1: Image Red 090degree                                %
%  IR2: Image Red 045degree                                %
%  IR3: Image Red 000degree                                %
%  IR4: Image Red 135degree                                %
%  IG1: Image Green 090degree                              %
%  IG2: Image Green 045degree                              %
%  IG3: Image Green 000degree                              %
%  IG4: Image Green 135degree                              %
%  IB1: Image Blue 090degree                               %
%  IB2: Image Blue 045degree                               %
%  IB3: Image Blue 000degree                               %
%  IB4: Image Blue 135degree                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [IR1,IR2,IR3,IR4,IG1,IG2,IG3,IG4,IB1,IB2,IB3,IB4]=SonyPolarImageCrop(I1)

[n,m,~] = size(I1);
I_RAW = double(I1);
IR1 = imcrop(I_RAW(:,:,1),[1 1 m/2-1 n/2-1]);
IR2 = imcrop(I_RAW(:,:,1),[m/2+1 1 m/2-1 n/2-1]);
IR3 = imcrop(I_RAW(:,:,1),[m/2+1 n/2+1 m/2-1 n/2-1]);
IR4 = imcrop(I_RAW(:,:,1),[1 n/2+1 m/2-1 n/2-1]);
IG1 = imcrop(I_RAW(:,:,2),[1 1 m/2-1 n/2-1]);
IG2 = imcrop(I_RAW(:,:,2),[m/2+1 1 m/2-1 n/2-1]);
IG3 = imcrop(I_RAW(:,:,2),[m/2+1 n/2+1 m/2-1 n/2-1]);
IG4 = imcrop(I_RAW(:,:,2),[1 n/2+1 m/2-1 n/2-1]);
IB1 = imcrop(I_RAW(:,:,3),[1 1 m/2-1 n/2-1]);
IB2 = imcrop(I_RAW(:,:,3),[m/2+1 1 m/2-1 n/2-1]);
IB3 = imcrop(I_RAW(:,:,3),[m/2+1 n/2+1 m/2-1 n/2-1]);
IB4 = imcrop(I_RAW(:,:,3),[1 n/2+1 m/2-1 n/2-1]);

