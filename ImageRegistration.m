%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        Image Registration Process                        %
%                                                          %
%    Copyright (C) 2020 Liu Xiao. All rights reserved.     %
%                    liux@aiofm.ac.cn                      %
%    image_moving->����׼ͼ��                              %
%    image_fixed->��׼ͼ��                                 %
%    image_reg->��׼���                                   %
%                                                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [image_reg] = ImageRegistration(image_fixed,image_moving)

[optimizer, metric] = imregconfig('multimodal');
optimizer.InitialRadius = optimizer.InitialRadius/3.5;
optimizer.MaximumIterations = 300;
tformSimilarity = imregtform(image_moving,image_fixed,'similarity',optimizer,metric);
image_reg = imregister(image_moving, image_fixed, 'affine', optimizer, metric,'InitialTransformation',tformSimilarity);
