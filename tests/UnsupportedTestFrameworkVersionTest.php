<?php

declare(strict_types=1);

namespace Infection\AbstractTestFramework;

use PHPUnit\Framework\TestCase;

/**
 * @covers \Infection\AbstractTestFramework\UnsupportedTestFrameworkVersion
 */
final class UnsupportedTestFrameworkVersionTest extends TestCase
{
    public function test_it_can_be_instantiated(): void
    {
        $exception = new UnsupportedTestFrameworkVersion('3.2.0', '6.0.0');

        $this->assertSame('3.2.0', $exception->getDetectedVersion());
        $this->assertSame('6.0.0', $exception->getMinimumSupportedVersion());

        $this->assertSame('', $exception->getMessage());
        $this->assertSame(0, $exception->getCode());
        $this->assertNull($exception->getPrevious());
    }
}
