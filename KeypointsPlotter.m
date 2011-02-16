classdef KeypointsPlotter
    methods
        function plot(self, points)
            hold on;
            for i=1:size(points, 1)
                plot(points{i}.y, points{i}.x, 'ro');
            end
        end
    end
end
