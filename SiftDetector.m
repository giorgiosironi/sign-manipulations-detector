classdef SiftDetector
    properties
        peakThresh;
    end
    methods
        function obj = SiftDetector(peakThresh)
            obj.peakThresh = peakThresh;
        end
        function points = findKeypoints(self, image)
            points = cell(0);
            [f, d] = vl_sift(image, 'PeakThresh', self.peakThresh);
            for i=1:size(f, 2)
                values = f(:, i);
                descriptor = d(:, i);
                newKeypoint = cell(1);
                newKeypoint{1} = Keypoint(values(2), values(1), values(3), values(4), descriptor);
                points = [points; newKeypoint];
            end
        end
    end
end
