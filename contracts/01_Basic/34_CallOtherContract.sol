// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/*
Contract can call other contracts in 2 ways.
The easiest way to is to just call it, like A.foo(x, y, z).
Another way to call other contracts is to use the low-level call.
This method is not recommended.
*/

contract Callee {
    uint256 public x;
    uint256 public value;

    function setX(uint256 _x) public returns (uint256) {
        x = _x;
        return x;
    }

    function setXandSendEther(uint256 _x)
        public
        payable
        returns (uint256, uint256)
    {
        x = _x;
        value = msg.value;

        return (x, value);
    }
}

contract Caller {
    function setX(Callee _callee, uint256 _x) public returns (uint256) {
        uint256 x = _callee.setX(_x);
        return x;
    }

    function setXFromAddress(address _addr, uint256 _x) public {
        Callee callee = Callee(_addr);
        callee.setX(_x);
    }

    function setXandSendEther(Callee _callee, uint256 _x)
        public
        payable
        returns (uint256, uint256)
    {
        (uint256 x, uint256 value) = _callee.setXandSendEther{value: msg.value}(
            _x
        );
        return (x, value);
    }
}
