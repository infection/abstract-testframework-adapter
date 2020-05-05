<?php

declare(strict_types=1);

namespace Infection\AbstractTestFramework;

use Error;
use PHPUnit\Framework\TestCase;

/**
 * @covers \Infection\AbstractTestFramework\InvalidVersion
 */
final class InvalidVersionTest extends TestCase
{
    public function test_it_can_be_instantiated(): void
    {
        $error = new Error();
        $exception = new InvalidVersion('Foo', 0, $error);

        $this->assertSame('Foo', $exception->getMessage());
        $this->assertSame(0, $exception->getCode());
        $this->assertSame($error, $exception->getPrevious());
    }
}
