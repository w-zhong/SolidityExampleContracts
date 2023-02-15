// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/**
 * Immutable variables are constants that are set at the time of deployment with constructor arguments.
 */

contract Immutable {
    // coding convention to name immutable variables in all caps
    address public immutable MY_ADDRESS;
    uint256 public immutable MY_UINT;

    constructor(address _address, uint256 _uint) {
        MY_ADDRESS = _address;
        MY_UINT = _uint;
    }
}
