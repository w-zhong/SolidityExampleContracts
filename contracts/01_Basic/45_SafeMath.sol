// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Since Solidity 0.8, safe math is built-in, so we don't need to use SafeMath library anymore.

contract SafeMath {
    // will be reverted
    function testUnderflow() public pure returns (uint256) {
        uint256 a = 0;
        return a - 1;
    }

    // will not be reverted
    function testUncheckedUnderflow() public pure returns (uint256) {
        unchecked {
            uint256 a = 0;
            return a - 1;
        }
    }
}

// Disable overflow check save gas
contract UncheckedMath {
    function add(uint256 x, uint256 y) external pure returns (uint256) {
        // 22291 gas
        // return x + y;

        // 22103 gas
        unchecked {
            return x + y;
        }
    }

    function sub(uint256 x, uint256 y) external pure returns (uint256) {
        // 22329 gas
        // return x - y;

        // 22147 gas
        unchecked {
            return x - y;
        }
    }

    function sumOfCubes(uint256 x, uint256 y) external pure returns (uint256) {
        // Wrap complex math logic inside unchecked
        unchecked {
            uint256 x3 = x * x * x;
            uint256 y3 = y * y * y;

            return x3 + y3;
        }
    }
}
