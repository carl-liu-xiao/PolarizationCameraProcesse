%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        Multispectral Polarization Image Process          %
%             (Camera: SALSA)                              %       
%                                                          %
%    Copyright (C) 2020 Liu Xiao. All rights reserved.     %
%                    liux@aiofm.ac.cn                      %
%                                                          %
%  MultispectralPolarSALSA : get the Stokes Images from    %
%   SALSA camera.                                          %
%  Input Parameters:                                       %
%  I01: Raw Polarization Image( frame1 image)              %
%  I02: Raw Polarization Image( frame2 image)              %
%  I03: Raw Polarization Image( frame3 image)              %
%  I04: Raw Polarization Image( frame4 image)              %
%  Wavelength: MultispectralPolarSALSA Wavelength          %
%  ----->>>[1->Green,2->Red,3->490nm,4-550nm,5->670nm]     %
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
%  S3: Stokes Parameter Image                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [S0,S1,S2,S3] = MultispectralPolarSALSA(I01,I02,I03,I04,Wavelength,Start_X,Start_Y,Size_X,Size_Y,ImgReg)

% 设置定标系数
C_Green=[0.550168,0.676124,-0.306891,0.091562;...
0.434429,-0.701683,0.272127,-0.009821;...
-0.364853,0.609882,-1.619882,1.379533;...
0.956288,0.574094,-0.588499,-0.929673];

C_Red=[0.149922,0.657810,-0.225890,0.421304;...
0.255833,-0.883493,0.465708,0.159649;...
-0.481169,1.053344,-1.515005,0.942470;...
1.287552,0.081515,-0.223654,-1.141392];

C_490=[0.814893,0.773285,-0.585495,-0.004211;...
0.577057,-0.529642,-0.077019,0.025358;...
0.183582,-0.244058,-3.211704,3.277137;...
0.874518,0.831317,-1.287658,-0.433313];

C_550=[0.538803,0.683244,-0.289351,0.084536;...
0.400168,-0.714004,0.283541,0.023687;...
-0.309483,0.671646,-1.575893,1.220588;...
0.949023,0.481115,-0.451660,-0.959629];

C_670=[-0.071552,0.68387,-0.202164,0.595418;...
0.151612,-0.922676,0.491678,0.272713;...
-0.388997,1.199275,-1.558267,0.753407;...
1.56456,-0.176091,-0.036392,-1.341694];

% 判断输入波长
switch Wavelength
    case 1
        C_TEMP = C_Green;
    case 2
        C_TEMP = C_Red;
    case 3
        C_TEMP = C_490;
    case 4
        C_TEMP = C_550;
    case 5
        C_TEMP = C_670;
    otherwise
        C_TEMP = zeros(4,4);
end

%判断是否进行配准
if ImgReg == 1
    I02 = ImageRegistration(I01,I02);
    I03 = ImageRegistration(I01,I03);
    I04 = ImageRegistration(I01,I04);
end

S0_TEMP=C_TEMP(1,1)*double(I01)+C_TEMP(1,2)*double(I02)+C_TEMP(1,3)*double(I03)+C_TEMP(1,4)*double(I04);
S1_TEMP=C_TEMP(2,1)*double(I01)+C_TEMP(2,2)*double(I02)+C_TEMP(2,3)*double(I03)+C_TEMP(2,4)*double(I04);
S2_TEMP=C_TEMP(3,1)*double(I01)+C_TEMP(3,2)*double(I02)+C_TEMP(3,3)*double(I03)+C_TEMP(3,4)*double(I04);
S3_TEMP=C_TEMP(4,1)*double(I01)+C_TEMP(4,2)*double(I02)+C_TEMP(4,3)*double(I03)+C_TEMP(4,4)*double(I04);

%判断是否有图像切割
if Size_X==0&&Size_Y==0&&Start_X==0&&Start_Y==0
    S0 = S0_TEMP;
    S1 = S1_TEMP;
    S2 = S2_TEMP;
    S3 = S3_TEMP;
else
    S0 = imcrop(S0_TEMP,[Start_X,Start_Y,Size_X,Size_Y]);
    S1 = imcrop(S1_TEMP,[Start_X,Start_Y,Size_X,Size_Y]);
    S2 = imcrop(S2_TEMP,[Start_X,Start_Y,Size_X,Size_Y]);
    S3 = imcrop(S3_TEMP,[Start_X,Start_Y,Size_X,Size_Y]);
end
