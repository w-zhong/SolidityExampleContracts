// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/**
 * Transactions are paid with ether, 1 ether is equal to 1e18 wei.
 * Wei is the default unit of ether.
 */

contract EtherUnits {
    uint256 public oneWei = 1 wei;
    // 1 wei is equal to 1
    bool public isOneWei = 1 wei == 1;
    uint256 public oneEther = 1 ether;
    // 1 ether is equal to 1e18
    bool public isOneEther = 1 ether == 1e18;
}
