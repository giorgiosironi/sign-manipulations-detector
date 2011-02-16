classdef GeneticMutator
    properties
        probability;
    end
    methods
        function obj = GeneticMutator(probability)
            obj.probability = probability;
        end
        function mutated = mutate(self, chromosome)
            mutated = chromosome;
            if (rand() < self.probability)
                length = size(chromosome, 1);
                toSwap = randsample(length, 2);
                new1 = KeypointsPair(chromosome{toSwap(1)}.first, chromosome{toSwap(2)}.second);
                new2 = KeypointsPair(chromosome{toSwap(2)}.first, chromosome{toSwap(1)}.second);
                mutated{toSwap(1)} = new1;
                mutated{toSwap(2)} = new2;
            end
        end
    end
end
