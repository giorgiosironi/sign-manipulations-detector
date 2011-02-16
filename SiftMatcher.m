classdef SiftMatcher
    properties
        threshold;
    end
    methods
        function obj = SiftMatcher(threshold)
            if (nargin < 1)
                threshold = 3;
            end
            obj.threshold = threshold;
        end
        function pairs = matchKeypoints(self, first_image, second_image)
            first_descriptors = self.extractDescriptors(first_image);
            second_descriptors = self.extractDescriptors(second_image);
            [matches, scores] = vl_ubcmatch(first_descriptors, second_descriptors, self.threshold);
            pairs = cell(0);
            for i=1:size(matches, 2)
                first_position = matches(1, i);
                second_position = matches(2, i);
                result = cell(1); 
                result{1} = KeypointsPair(first_image{first_position}, second_image{second_position});
                pairs = [pairs; result];
            end
        end
        function descriptors = extractDescriptors(self, image)
            descriptors = [];
            for i=1:size(image, 1)
                keypoint = image{i};
                descriptors = [descriptors keypoint.descriptor];
            end
        end
    end
end
