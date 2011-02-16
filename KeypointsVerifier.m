classdef KeypointsVerifier
    methods
        function keypoints = getFirstImageKeypoints(self, pairs)
            keypoints = cell(size(pairs, 1), 1);
            for i=1:size(pairs, 1)
                first = pairs{i}.first;
                keypoints{i} = first;
            end
        end
        function keypoints = getSecondImageKeypoints(self, pairs)
            keypoints = cell(size(pairs, 1), 1);
            for i=1:size(pairs, 1)
                second = pairs{i}.second;
                keypoints{i} = second;
            end
        end
    end
end
