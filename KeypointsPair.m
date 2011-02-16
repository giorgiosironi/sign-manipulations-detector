classdef KeypointsPair < handle
    properties (SetAccess = private, GetAccess = public)
        first;
        second;
    end
    methods
        function obj = KeypointsPair(first, second)
            obj.first = first;
            obj.second = second;
        end
        function matrix = getCostMatrix(self)
            A = zeros(2, 9); 
            homogeneousFirst = [self.first.x self.first.y 1];
            homogeneousSecond = [self.second.x self.second.y 1];
            A(1, 4:6) = -1 * homogeneousFirst;
            A(1, 7:9) = self.second.y * homogeneousFirst;
            A(2, 1:3) = homogeneousFirst;
            A(2, 7:9) = -1 * self.second.x * homogeneousFirst;
            matrix = CostMatrix(A);
        end
    end
end
