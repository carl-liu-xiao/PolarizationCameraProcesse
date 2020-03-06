%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        Image Registration Process                        %
%                                                          %
%    Copyright (C) 2020 Liu Xiao. All rights reserved.     %
%                    liux@aiofm.ac.cn                      %
%    image_moving->待配准图像                              %
%    image_fixed->基准图像                                 %
%    image_reg->配准结果                                   %
%                                                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [image_reg] = ImageRegistration(image_fixed,image_moving)

[optimizer, metric] = imregconfig('multimodal');
optimizer.InitialRadius = optimizer.InitialRadius/3.5;
optimizer.MaximumIterations = 300;
tformSimilarity = imregtform(image_moving,image_fixed,'similarity',optimizer,metric);
image_reg = imregister(image_moving, image_fixed, 'affine', optimizer, metric,'InitialTransformation',tformSimilarity);
