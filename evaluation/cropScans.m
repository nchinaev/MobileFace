indices_path       = './data/indices/';
scans_path         = './data/scans/';
cropped_scans_path = './data/scans_cropped/';

files = dir(indices_path);

parfor_progress(length(files) - 2);
parfor i = 3:length(files)
    
    fname = files(i).name;
    
    indices = dlmread([indices_path, fname]);
    
    scan = dlmread([scans_path, fname]);
    
    scan_cropped = scan(indices, :);
    
    dlmwrite([cropped_scans_path, fname], scan_cropped, 'delimiter', ' ')
    
    parfor_progress;
end
parfor_progress(0);