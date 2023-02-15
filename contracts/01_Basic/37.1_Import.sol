// SPDX-License-Identifier: MIT

/**
You can import local and external files in Solidity.
Here is our folder structure.
├── Import.sol
└── Foo.sol
 */

// this will be imported by 37.2_Import.sol
pragma solidity ^0.8.17;

struct Point {
    uint256 x;
    uint256 y;
}

error Unauthorized(address caller);

function add(uint256 x, uint256 y) pure returns (uint256) {
    return x + y;
}

contract Foo {
    string public name = "Foo";
}
