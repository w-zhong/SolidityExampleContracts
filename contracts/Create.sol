// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

// create contract with assembly from another contract
contract Create {
    event Deploy(address);
    event Execute(bool, bytes);

    receive() external payable {}

    // deploy contract with assembly
    // 1. callvalue() = msg.value
    // 2. bytecode from target contract
    function deploy(bytes memory _code)
        external
        payable
        returns (address addr)
    {
        assembly {
            // create(v, p, n)
            // v = amount of ETH to send, callvalue() = msg.value
            // p = pointer in memory to start of code, add(_code, 0x20) = start of code
            // the first 32 bytes of the code is the size of the code, so actual code starts at 32/0x20
            // n = size of code, mload(_code) = size of code
            addr := create(callvalue(), add(_code, 0x20), mload(_code))
        }
        // return address 0 on error
        require(addr != address(0), "deploy failed");

        emit Deploy(addr);
    }

    // excute function with assembly from another contract
    // 1. msg.value
    // 2. address of target contract -> _target
    // 3. calldata -> _data
    function execute(address _target, bytes memory _data) external payable {
        (bool success, bytes memory data) = _target.call{value: msg.value}(
            _data
        );
        require(success, "failed");
        emit Execute(success, data);
    }
}

contract TargetContract1 {
    address public owner = msg.sender;

    function setOwner(address _owner) public {
        require(msg.sender == owner, "not owner");
        owner = _owner;
    }
}

contract TargetContract2 {
    address public owner = msg.sender;
    uint256 public value = msg.value;
    uint256 public x;
    uint256 public y;

    constructor(uint256 _x, uint256 _y) payable {
        x = _x;
        y = _y;
    }
}

// get bytecode and calldata from target contract
contract Helper {
    function getBytecode1() external pure returns (bytes memory) {
        bytes memory bytecode = type(TargetContract1).creationCode;
        return bytecode;
    }

    function getBytecode2(uint256 _x, uint256 _y)
        external
        pure
        returns (bytes memory)
    {
        bytes memory bytecode = type(TargetContract2).creationCode;
        return abi.encodePacked(bytecode, abi.encode(_x, _y));
    }

    function getCalldata(address _owner) external pure returns (bytes memory) {
        return abi.encodeWithSignature("setOwner(address)", _owner);
    }
}
