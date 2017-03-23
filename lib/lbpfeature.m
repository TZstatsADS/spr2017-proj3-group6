conf.calDir = './' ; % calculating directory
conf.dataDir = './images/' ; % data (image) directory 


file = fopen('train_img_names.csv');
imagenames = textscan(file, '%s %*[^\n]');
fclose(file);
imagenames = imagenames{:};
imagenames = imagenames(2:end);
[nfiles, s] = size(imagenames);

  for ii = 1:nfiles
    fprintf('Processing dictionary %s (%.2f %%)\n', imagenames{ii}, 100 * ii /nfiles) ;
    currentFileName = imagenames{ii};
    imm = imread(fullfile(conf.dataDir,currentFileName));    
        im = imresize(imm, [480 480]);    
     lbpFeatures = extractLBPFeatures(im,'CellSize',[32 32],'Normalization','None'); 
%%
% Reshape the LBP features into a _number of neighbors_ -by- _number of cells_ array to access histograms for each individual cell.
numNeighbors = 8;
numBins = numNeighbors*(numNeighbors-1)+3;
lbpCellHists = reshape(lbpFeatures,numBins,[]); 
%%
% Normalize each LBP cell histogram using L1 norm.
lbpCellHists = bsxfun(@rdivide,lbpCellHists,sum(lbpCellHists)); 
%%
% Reshape the LBP features vector back to 1-by- _N_ feature vector.
lbpFeatures = reshape(lbpCellHists,1,[]); 
W(ii,:)=lbpFeatures;
  end
 
 csvwrite('feature_lbp.csv',W) 
  