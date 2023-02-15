// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/**
 * Constants are variables that can not be modified.
 * Their value is hard coded and using them is cheaper than using a storage variable.
 */

contract Constants {
    // coding convention to name constant variables in all caps
    address public constant MY_ADDRESS =
        0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    uint256 public constant MY_UINT = 123;
}
