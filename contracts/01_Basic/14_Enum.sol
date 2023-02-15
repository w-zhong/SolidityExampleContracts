// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

// Solidity supports enumerables and they are useful to model choice and keep track of state.
// Enums can be declared outside of a contract.

contract Enum {
    // Enum representing shipping status
    enum Status {
        Pending,
        Shipped,
        Accepted,
        Rejected,
        Canceled
    }

    // Default value is the first element listed in definition of the type, in this case "Pending".
    Status public status;

    // Returns uint
    // Pending  - 0
    // Shipped  - 1
    // Accepted - 2
    // Rejected - 3
    // Canceled - 4
    function get() public view returns (Status) {
        return status;
    }

    // Update status by passing uint8 into input 0, 1, 2, 3 or 4
    function set(Status _status) public {
        status = _status;
    }

    // You can update to a specific enum like this -> 4
    function cancel() public {
        status = Status.Canceled;
    }

    // delete resets the enum to its first value -> 0
    function reset() public {
        delete status;
    }
}

// Enum can be declared outside a contract or in a sperate file.
// If the following is saved in 'EnumDeclaration.sol'.
// Then you can import it into your contract with <import "./EnumDeclaration.sol>.
enum Status1 {
    Pending,
    Shipped,
    Accepted,
    Rejected,
    Canceled
}
