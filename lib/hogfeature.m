
conf.calDir = './' ; % calculating directory
conf.dataDir = './images/' ; % data (image) directory 

file = fopen('train_img_names.csv');
imagenames = textscan(file, '%s %*[^\n]');
fclose(file);
imagenames = imagenames{:};
imagenames = imagenames(2:end);
[nfiles, s] = size(imagenames);

%Extract histogram of oriented gradients (HOG) features
  for ii = 1:nfiles
    fprintf('Processing dictionary %s (%.2f %%)\n', imagenames{ii}, 100 * ii /nfiles) ;
    currentFileName = imagenames{ii};
    imm = imread(fullfile(conf.dataDir,currentFileName));    
        im = imresize(imm, [480 480]);    
     
hogFeatures = extractHOGFeatures(im); 
A(ii,:)=hogFeatures;
  end
 
 csvwrite('feature_hog.csv',A) 
  