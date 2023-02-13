// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

/**
 1. call
 A ---> B, send 100 wei
        B ---> C, send 200 wei
 A ---> B ---> C, msg.sender = B, msg.value = 200 wei, excute code on C's state variables, use ETH in C

 2. delegatecall
 A ---> B, send 100 wei
        B ---> C, send 200 wei
 A ---> B ---> C, msg.sender = A, msg.value = 100 wei, excute code on B's state variables, use ETH in B

 3. the state variables in B and C should be the same, including their sequence

 4. Delegate calls only to trusted contracts, because the called contract has access to the storage of the calling contract.
    
 5. Never delegate call a user-supplied address.          
 */

// B
contract Proxy {
    uint256 public num;
    address public sender;
    uint256 public value;

    function setNum(address _logic, uint256 _num) external payable {
        // (bool success, ) = _logic.delegatecall(
        //     abi.encodeWithSignature("setNum(uint256)", _num)
        // );
        // require(success, "delegatecall failed");

        // this is equivalent to above
        (bool success, ) = _logic.delegatecall(
            abi.encodeWithSelector(Logic.setNum.selector, _num)
        );
        require(success, "delegatecall failed");
    }
}

// C
contract Logic {
    uint256 public num;
    address public sender;
    uint256 public value;

    function setNum(uint256 _num) external payable {
        num = _num;
        sender = msg.sender;
        value = msg.value;
    }
}
