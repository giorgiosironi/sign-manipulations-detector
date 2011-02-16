function test_suite = testGeneticCrossover
initTestSuite;

function testCrossoverOfTwoChromosomesDoesNotInvolveTheFirstUsedToComputeHomography
crossover = GeneticCrossover();
chromosome = getFirstChromosome();
otherChromosome = getSecondChromosome();
result = crossover.cross(chromosome, otherChromosome);
assertEqual(chromosome(1:4), result(1:4));

function testCrossoverOfTwoChromosomesWithDifferentPointsIsPossible
crossover = GeneticCrossover();
chromosome = getFirstChromosome();
otherChromosome = getSecondChromosome();
otherChromosome{5} = KeypointsPair(9, otherChromosome{5}.second);
otherChromosome{6} = KeypointsPair(10, otherChromosome{6}.second);
otherChromosome{7} = KeypointsPair(11, otherChromosome{7}.second);
otherChromosome{8} = KeypointsPair(12, otherChromosome{8}.second);
result = crossover.cross(chromosome, otherChromosome);
assertEqual([8 1], size(result));
assertEqual(chromosome(1:4), result(1:4));

function chromosome = getFirstChromosome()
chromosome = cell(8, 1);
chromosome{1} = KeypointsPair(1, 'a');
chromosome{2} = KeypointsPair(2, 'b');
chromosome{3} = KeypointsPair(3, 'c');
chromosome{4} = KeypointsPair(4, 'd');
chromosome{5} = KeypointsPair(5, 'e');
chromosome{6} = KeypointsPair(6, 'f');
chromosome{7} = KeypointsPair(7, 'g');
chromosome{8} = KeypointsPair(8, 'h');

function chromosome = getSecondChromosome()
chromosome = cell(8, 1);
chromosome{1} = KeypointsPair(1, 'h');
chromosome{2} = KeypointsPair(2, 'g');
chromosome{3} = KeypointsPair(3, 'f');
chromosome{4} = KeypointsPair(4, 'e');
chromosome{5} = KeypointsPair(5, 'd');
chromosome{6} = KeypointsPair(6, 'c');
chromosome{7} = KeypointsPair(7, 'b');
chromosome{8} = KeypointsPair(8, 'a');

