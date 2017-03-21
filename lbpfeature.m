% Extract SIFT features for poddle vs. fried chicken image set
% Require vlfeat-0.9.20
% Adapted codes from http://www.vlfeat.org/applications/caltech-101-code.html
% run('~/Documents/MATLAB/vlfeat-0.9.20/toolbox/vl_setup'

conf.calDir = './' ; % calculating directory
conf.dataDir = './images/' ; % data (image) directory 
conf.outDir = './output2/'; % output directory
conf.numWords = 5000 ; % vocabulary size
conf.numSpatialX = 1 ; % spatial histogram configuration
conf.numSpatialY = 1 ;
conf.quantizer = 'kdtree' ; % search structure

conf.prefix = 'sift_pf' ;
conf.randSeed = 1 ;

conf.descrPath = fullfile(conf.outDir,[conf.prefix '-descr.mat']);
conf.vocabPath = fullfile(conf.outDir, [conf.prefix '-vocab.mat']);
conf.histPath = fullfile(conf.outDir, [conf.prefix '-hists.mat']) ;
conf.modelPath = fullfile(conf.outDir, [conf.prefix '-model.mat']) ;
conf.resultPath = fullfile(conf.outDir, [conf.prefix '-result']) ;


conf.descrPath = fullfile(conf.outDir, [conf.prefix '-selectedDescr.mat']);
conf.framePath = fullfile(conf.outDir, [conf.prefix '-selectedFrame.mat']);

randn('state',conf.randSeed) ;
rand('state',conf.randSeed) ;


model.numSpatialX = conf.numSpatialX ;
model.numSpatialY = conf.numSpatialY ;
model.quantizer = conf.quantizer ;
model.vocab = [] ;

% --------------------------------------------------------------------
%                                                     Train vocabulary
% --------------------------------------------------------------------

file = fopen('train_img_names.csv');
imagenames = textscan(file, '%s %*[^\n]');
fclose(file);
imagenames = imagenames{:};
imagenames = imagenames(2:end);
[nfiles, s] = size(imagenames);



  % Get some SIFT descriptors to train the dictionary
  descrs = {} ;
  frame = {};
  img_names = {};
  %for ii = 1:length(selTrainFeats)
  %for ii = 1:nfiles
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
 
 csvwrite("fea.csv",W) 
  