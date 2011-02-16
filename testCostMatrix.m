function test_suite = testCostMatrix
initTestSuite;

function testConstructorAcceptsWrappedMatlabMatrix
sample = ones(2, 9);
matrix = CostMatrix(sample);
assertEqual(sample, matrix.A);

function testCombinesItselfWithAnotherCostMatrix
original = CostMatrix(ones(2, 9));
addition = CostMatrix(2 * ones(2, 9));
result = original.combineWith(addition);
assertEqual([1; 1; 2; 2], result.A(:, 1));

function testCalculatesRightVectorWhichResultsInAMinimum
matrix = CostMatrix(ones(2, 9));
vector = matrix.getMinimumVector();
assertElementsAlmostEqual(1, norm(vector));
assertVectorsAlmostEqual(zeros(2, 1), ones(2, 9) * vector); 
