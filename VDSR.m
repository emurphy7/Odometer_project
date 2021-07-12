function VDSR(focal_stack_dir)
current_path = pwd;
folder = strcat(current_path, '/', focal_stack_dir);
result_Folder = strcat(current_path, '/', focal_stack_dir, '_VDSR_result')
file = fullfile(folder, '*.jpg');
jpg_images = dir(file);
jpg_images(1).name
image_1 = imread(fullfile(folder, jpg_images(1).name));
net = load('trainedVDSR-Epoch-100-ScaleFactors-234.mat');
net = net.net;
[nrows,ncols,np] = size(image_1);
%if nrows < 1000
nrows = nrows *2;
ncols = ncols *2;
Iycbcr = rgb2ycbcr(image_1);
Iy = Iycbcr(:,:,1);
Icb = Iycbcr(:,:,2);
Icr = Iycbcr(:,:,3);
Iy_bicubic = double(imresize(Iy,[nrows ncols],'bicubic'));
Icb_bicubic = imresize(Icb,[nrows ncols],'bicubic');
Icr_bicubic = imresize(Icr,[nrows ncols],'bicubic');
Iresidual = activations(net,Iy_bicubic,41);
Iresidual = double(Iresidual);
Isr = Iy_bicubic + Iresidual;
image_1 = ycbcr2rgb(cat(3,Isr,Icb_bicubic,Icr_bicubic));
%end
cd (result_Folder)
name = strcat('result_', jpg_images(1).name);
imwrite(image_1,name);
for i = 2:length(jpg_images)
  image = imread(fullfile(folder, jpg_images(i).name));
  [nrows,ncols,np] = size(image);
  %if nrows < 1000
  nrows = nrows *2;
  ncols = ncols *2;
  Iycbcr = rgb2ycbcr(image);
  Iy = Iycbcr(:,:,1);
  Icb = Iycbcr(:,:,2);
  Icr = Iycbcr(:,:,3);
  Iy_bicubic = double(imresize(Iy,[nrows ncols],'bicubic'));
  Icb_bicubic = imresize(Icb,[nrows ncols],'bicubic');
  Icr_bicubic = imresize(Icr,[nrows ncols],'bicubic');
  Iresidual = activations(net,Iy_bicubic,41);
  Iresidual = double(Iresidual);
  Isr = Iy_bicubic + Iresidual;
  image = ycbcr2rgb(cat(3,Isr,Icb_bicubic,Icr_bicubic));
%  end
  cd (result_Folder)
  name = strcat('result_', jpg_images(i).name);
  imwrite(image,name);
end
end