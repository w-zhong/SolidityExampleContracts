// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/**
 * To write or update a state variable you need to send a transaction.
 * On the other hand, you can read state variables, for free, without any transaction fee.
 */

contract SimpileStorage {
    // state variable to store a number
    uint256 public num;

    // send a transaction to write to the state variable
    function set(uint256 _num) public {
        num = _num;
    }

    // read the state variable for free
    function get() public view returns (uint256) {
        return num;
    }
}
