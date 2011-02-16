classdef ImageCutter
    methods 
        function newImage = cut(self, im, keypoints)
            minimum_x = size(im, 1);
            minimum_y = size(im, 2);
            maximum_x = 1;
            maximum_y = 1;
            for i=1:size(keypoints, 1)
                if (keypoints{i}.x < minimum_x)
                    minimum_x = keypoints{i}.x;
                end
                if (keypoints{i}.y < minimum_y)
                    minimum_y = keypoints{i}.y;
                end
                if (keypoints{i}.x > maximum_x)
                    maximum_x = keypoints{i}.x;
                end
                if (keypoints{i}.y > maximum_y)
                    maximum_y = keypoints{i}.y;
                end
            end
            minimum_x = uint16(minimum_x);
            minimum_y = uint16(minimum_y);
            maximum_x = uint16(maximum_x);
            maximum_y = uint16(maximum_y);
            newImage = im(minimum_x:maximum_x, minimum_y:maximum_y);
        end
    end
end
