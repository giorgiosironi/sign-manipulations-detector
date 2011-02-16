classdef DuplicateFilter
    properties
        tolerance;
    end
    methods
        function obj = DuplicateFilter(tolerance)
            obj.tolerance = tolerance;
        end
        function filtered = filter(self, pairs)
            filtered = cell(0);
            for i=1:size(pairs, 1)
                duplicate = 0;
                for j=1:i-1
                    if (pairs{i}.first.distanceFrom(pairs{j}.first) < self.tolerance && pairs{i}.second.distanceFrom(pairs{j}.second) < self.tolerance)
                        duplicate = 1;
                    end
                end
                if (~duplicate)
                    filtered = [filtered; {pairs{i}}];
                end
            end
        end
    end
end
