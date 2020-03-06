%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        Multispectral Polarization Image Process          %
%             (Camera: Fluxdata FD1665P)                   %       
%                                                          %
%    Copyright (C) 2020 Liu Xiao. All rights reserved.     %
%                    liux@aiofm.ac.cn                      %
%                                                          %
%  MultispectralPolar : get the Stokes Images from         %
%   different polarization angle and different wavelengt.  %
%  Input Parameters:                                       %
%  I000: Raw Polarization Image( 0 degree image)           %
%  I045: Raw Polarization Image( 45 degree image)          %
%  I090: Raw Polarization Image( 90 degree image)          %
%  Start_X: Valid Image X Axis                             %
%  Start_Y: Valid Image Y Axis                             %
%  Size_X: Valid Image X Size                              %
%  Size_Y: Valid Image Y Size                              %
%  ImgReg: 1=Run ImageRegistration,0=None ImageRegistration%
%                                                          %
%  Output Parameters:                                      %
%  S0: Stokes Parameter Image                              %
%  S1: Stokes Parameter Image                              %
%  S2: Stokes Parameter Image                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [S0,S1,S2]=MultispectralPolarFluxdata(I000,I045,I090,Start_X,Start_Y,Size_X,Size_Y,ImgReg)

% [m,n] = size(I000);
if Size_X==0&&Size_Y==0&&Start_X==0&&Start_Y==0
    I000_TEMP = double(I000);
    I045_TEMP = double(I045);
    I090_TEMP = double(I090);
else
    I000_TEMP = double(imcrop(I000,[Start_X,Start_Y,Size_X,Size_Y]));
    I045_TEMP = double(imcrop(I045,[Start_X,Start_Y,Size_X,Size_Y]));
    I090_TEMP = double(imcrop(I090,[Start_X,Start_Y,Size_X,Size_Y]));
end
%图像配准
if ImgReg == 1
    I045_TEMP = ImageRegistration(I000_TEMP,I045_TEMP);
    I090_TEMP = ImageRegistration(I000_TEMP,I090_TEMP);
end

%计算STOKES参量
S0 = I000_TEMP + I090_TEMP;
S1 = I000_TEMP - I045_TEMP;
S2 = 2*I045_TEMP - S0;

