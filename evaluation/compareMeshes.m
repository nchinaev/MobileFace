function [d, it_num] = compareMeshes(V_align_to, pts_align_to, V_being_aligned, pts_being_aligned, tol, max_iterations)

if(nargin == 4)
    tol = 0.000001;
end

if(nargin <= 5)
  max_iterations = 100;
end

MdlKDT = KDTreeSearcher(V_align_to);

it_num = 0;

d_prev = 0;
d = Inf;

[~, ~, transform] = procrustes(pts_align_to, pts_being_aligned, 'reflection', false);

while(abs(d - d_prev) > tol && it_num < max_iterations)
    
    V_being_aligned = transform.b * V_being_aligned * transform.T + repmat(transform.c(1, :), [size(V_being_aligned, 1), 1]);

    inds = knnsearch(MdlKDT, V_being_aligned);
    projections = V_align_to(inds, :);
    
    d_prev = d;
    
    [d, ~, transform] = procrustes(projections, V_being_aligned, 'reflection', false);
    
    it_num = it_num + 1;
end