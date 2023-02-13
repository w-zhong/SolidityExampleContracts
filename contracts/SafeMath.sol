// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

/**
 Since Solidity 0.8, safe math is built-in, so we don't need to use SafeMath library anymore.
 */

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
