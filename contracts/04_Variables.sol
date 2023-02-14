// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/*
State variables are stored permanently in contract storage.
The compiler automatically creates getter functions for public state variables.
1. Local
   Declared inside a function, not stored on the blockchain
2. State
   declared outside a function, stored on the blockchain
3. Global
   Provides information about the blockchain
*/

contract Variables {
    // State variables are stored on the blockchain.
    string public stateStr = "Hello";
    uint256 public stateNum = 123;

    // Local variables are temporary, and are erased between external function calls to your contract.
    function doSomething()
        public
        view
        returns (
            uint256,
            bool,
            uint256,
            address
        )
    {
        // Local variables
        uint256 localNum = 456;
        bool localBool = true;

        // Global variables
        uint256 blockNumber = block.number;
        address sender = msg.sender;
        return (localNum, localBool, blockNumber, sender);
    }
}
