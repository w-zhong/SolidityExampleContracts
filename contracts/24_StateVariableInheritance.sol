// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract A {
    string public name = "Contract A";
}

// Shadowing is disallowed from Solidity 0.6
// This will not compile
// contract B is A {
//     string public name = "Contract B";
// }

// This is the correct way to override inherited state variables.
contract C is A {
    constructor() {
        name = "Contract C";
    }

    // C.getName returns "Contract C"
}
