function test_suite = testErrorCalculator
initTestSuite;

function testReturnsAZeroErrorForIdenticalImages
calculator = ErrorCalculator();
original = ones(100);
assertElementsAlmostEqual(0, calculator.getRMS(original, original));

function testReturnsNonZeroErrorForSlightlyDifferentImages
calculator = ErrorCalculator();
original = ones(100);
different = original;
different(1, 1) = 2;
assertTrue(calculator.getRMS(different, original) > 0);

function testReturnsMonotonicallyIncreasingErrorForMoreAndMoreDifferentImages
calculator = ErrorCalculator();
original = ones(100);
different = original;
different(1, 1) = 2;
more_different = original;
more_different(1, 1) = 3;
assertTrue(calculator.getRMS(more_different, original) > calculator.getRMS(different, original));
