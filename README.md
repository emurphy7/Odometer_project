**Pre-Processing:** 
The link to the dataset is: Odometer_project/small_data/small_odometer_dataset
In order to preprocess the data, the matlab folder will need to be downloaded. The image processing toolbox in matlab also needs to be installed. https://www.mathworks.com/products/image.html

Once this folder is download, move the small_odometer dataset into it. Create an empty folder for results titled: small_odometer_dataset_bicubic_result_sharpen 
From there run_file.m file can be run and this will create the processed images. 

The images will be doubled in resolution and sharpened. 


The next steps are run in the Full_Pipeline.ipynb

**Odometer Localization:** 

Odometer localization is the process of isolating the odometer display from the rest of the image. MobileNet V2 object detection model is used in order to identify the odometer display in the images. This can very easily be changed to the V1 version by changing a few lines of code in the configuration steps. The pre-processed images were not used in this step. The model is currently set to train an additional 10000 steps. To improve results this value can be changed. The output of this file is a csv with the most four most likely bounding boxes information.  Only the most likely bounding box is used for the character recognition stage.

**Character Recognition:**  
The Character recognition portion of this project also uses the MobleNet V2 as its object detection model. (Again this can be changed)  The input of this model in the cropped odometer screens and the coordinates of the bounding boxes of the characters on the screen. The images used for this section are the ones that were pre-processed to increased sharpness and resolution. The output of this models are the coordinates of the individual characters bounding boxes as well as their classification and classification score.

There are two trained graphs that can be used for the test - the one that is trained in the notebook and a model that I trained on the larger dataset. The model trained on the larger dataset will perform much better. 

**Post-Processing:**  
The values in some of these step may be changed to increase the accuracy of the model. Some examples of this are the threshold value(step 2), the closness percentage (step 5) and the exrapolation factor (step 6)

1. Filter bounding boxes that belong to non-digit character.
2. Filter bounding boxes by the classification score (10% was used)
3. Remove boxes that were contained in other bounding boxes
4. Calculate the median of all of the remaining bounding boxes. If any box lies far outside of
the median then the box is to be removed.
5. Remove all boxes that are close in xmin, xmax, ymin, and ymax values
6. Augment/extrapolate boxes in horizontal direction by a factor of the width along both sides.
- W idth was used for digits classified as one (This was done because the bounding boxes
for ’ones’ are normally smaller in width than other digits)
- W idth / 2.5 was used for all other digits.
7. Create a graph G where vertices represents bounding box and edges represent overlap between
two boxes.
8. Select subgraph with largest number of vertices.
9. Sort boxes in that subgraph horizontally and extract digits in order to form a mileage number.
10. If the mileage has 7 digits or is a value greater than 300k then the last digit is discarded

**Result:** 
The results consist of a true accuracy, an accuracy within 1000 miles and the labeled images. 

