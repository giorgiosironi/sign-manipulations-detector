classdef Keypoint < handle
    properties (SetAccess = private)
        x;
        y;
        scale;
        orientation;
        descriptor;
    end
    methods
        function obj = Keypoint(x, y, scale, orientation, descriptor)
            obj.x = x;
            obj.y = y;
            if (nargin > 2)
                obj.scale = scale;
                obj.orientation = orientation;
                obj.descriptor = descriptor;
            end
        end
        function b = isCollinearWith(self, b, c, tolerance)
            if (nargin < 4)
                tolerance = 0.1;
            end
            l = cross([b.x b.y 1], [c.x c.y 1]);
            d = l * [self.x self.y 1]';
            b = abs(d) < tolerance;
        end
        function d = distanceFrom(self, anotherPoint)
            d = norm([self.x - anotherPoint.x, self.y - anotherPoint.y]);
        end
    end
end
