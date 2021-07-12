function [rgb_stack, gray_stack] = loadFocalStack(focal_stack_dir)
current_path = pwd;
folder = strcat(current_path, '/', focal_stack_dir);
result_Folder = strcat(current_path, '/', focal_stack_dir, '_bicubic_result')
file = fullfile(folder, '*.jpg');
jpg_images = dir(file);
jpg_images(1).name
image_1 = imread(fullfile(folder, jpg_images(1).name));
[nrows,ncols,np] = size(image_1);
nrows = nrows *4;
ncols = ncols *4;
Ibicubic = imresize(image_1,[nrows ncols],'bicubic');
cd (result_Folder)
name = strcat('result_', jpg_images(1).name);
imwrite(Ibicubic,name);
for i = 2:length(jpg_images)
  image = imread(fullfile(folder, jpg_images(i).name));
  [nrows,ncols,np] = size(image_1);
  nrows = nrows *4;
  ncols = ncols *4;
  Ibicubic = imresize(image,[nrows ncols],'bicubic');
  cd (result_Folder)
  name = strcat('result_', jpg_images(i).name);
  imwrite(Ibicubic,name);
end
end