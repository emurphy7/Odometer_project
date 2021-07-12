function Bicubic(focal_stack_dir)
current_path = pwd;
folder = strcat(current_path, '/', focal_stack_dir);
result_Folder = strcat(current_path, '/', focal_stack_dir, '_bicubic_result')
file = fullfile(folder, '*.jpg');
jpg_images = dir(file);
jpg_images(1).name
image_1 = imread(fullfile(folder, jpg_images(1).name));
[nrows,ncols,np] = size(image_1);
%if nrows < 1000
nrows = nrows *2;
ncols = ncols *2;
image_1 = imresize(image_1,[nrows ncols],'bicubic');
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
  image = imresize(image,[nrows ncols],'bicubic');
  %end
  cd (result_Folder)
  name = strcat('result_', jpg_images(i).name);
  imwrite(image,name);
end
end