classdef ErrorCalculator
    methods
        function obj = ErrorCalculator()
        end
        function E = getRMS(self, image1, image2)
            difference = double(norm(image1 - image2) / 255);
            E = difference / sqrt(size(image1, 1) * size(image1, 2));
        end
    end
end
