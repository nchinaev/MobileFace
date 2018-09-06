
% select subset
%
%   either val_list.txt or test_list.txt

subset_filename = 'val_list.txt';

gt_dir  = './data/scans_cropped/';
csv_dir = './data/csv/';

%%
% set this path
%
%   - this directory should contain your reconstructed 3d models
%   - names of the files are the same as in scans_cropped folder
%   - the models should be stored in txt format
%   - 3 x,y,z coordinates per row

res_dir = '';

%
% prepare this file
%
%   7 keypoints are used to roughly align the reconstructed model and the
%   ground truth scan for ICP initialization.
% 
%   The indices of these keypoints in IBUG 68 landmark annotation scheme are
%   [37; 40; 43; 46; 31; 49; 55] (1-based)
%
%   In case your reconstructed models have the same structure (the same
%   amount of vertices with each vertex having consistent semantic meaning), 
%   you can annotate these 7 keypoints on your model and store their indices
%   in a 7x1 array.
%
%   See further comments in case your models don't have the same structure

load('keypoint_ids.mat');



%%
fid = fopen(['./data/', subset_filename], 'r');
lines = textscan(fid, '%s');
fclose(fid);
lines = lines{1, 1};

 
%%
distances = zeros(length(lines), 1);
iterations = zeros(length(lines), 1);
parfor_progress(length(lines));
parfor i = 1:length(lines)

    fname = lines{i};
    
    vertices_gt = dlmread([gt_dir, fname(1:end-3), 'txt']);
    
    pts_gt = dlmread([csv_dir, fname(1:end-3), 'csv'], ',', 1, 0);
    pts_gt = pts_gt([37; 40; 43; 46; 31; 49; 55],:);
    
    vertices = dlmread([res_dir, fname(1:end-3), 'txt']);
    
    % alternatively, you can load your keypoints from a file here
    pts = vertices(keypoints, :);
    
    [d, it] = compareMeshes(vertices, pts, vertices_gt, pts_gt, 0.000001);
    
    distances(i) = d;
    iterations(i) = it;
    parfor_progress;
end
parfor_progress(0);

%% output: distances