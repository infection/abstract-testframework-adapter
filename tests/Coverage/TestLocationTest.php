<?php

declare(strict_types=1);

namespace Infection\AbstractTestFramework\Coverage;

use PHPUnit\Framework\TestCase;

/**
 * @covers \Infection\AbstractTestFramework\Coverage\TestLocation
 */
final class TestLocationTest extends TestCase
{
    public function test_it_can_be_instantiated_for_a_method(): void
    {
        $testLocation = TestLocation::forTestMethod('mutatesNode');

        $this->assertTestLocationStateIs(
            $testLocation,
            'mutatesNode',
            null,
            null
        );
    }

    public function test_it_can_be_instantiated(): void
    {
        $testLocation = new TestLocation('mutatesNode', 'path/to/Test.php', 0.123);

        $this->assertTestLocationStateIs(
            $testLocation,
            'mutatesNode',
            'path/to/Test.php',
            0.123
        );
    }

    private function assertTestLocationStateIs(
        TestLocation $testLocation,
        string $expectedMethod,
        ?string $expectedFilePath,
        ?float $expectedExecutionTime
    ): void
    {
        $this->assertSame($expectedMethod, $testLocation->getMethod());
        $this->assertSame($expectedFilePath, $testLocation->getFilePath());
        $this->assertSame($expectedExecutionTime, $testLocation->getExecutionTime());
    }
}
