classdef MatlabHomographyEstimator
    methods
        function obj = HomographyEstimator
        end
        function T = getHomography(self, pairs)
            u = [];
            x = [];
            for i=1:size(pairs, 1)
                u = [u; [pairs{i}.first.y pairs{i}.first.x]];
                x = [x; [pairs{i}.second.y pairs{i}.second.x]];
            end
            T = maketform('projective', u, x);
        end
    end
end
