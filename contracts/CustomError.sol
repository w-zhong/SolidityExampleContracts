// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

/**
 Since Solidity 0.8, custom error is defined.
 Benefit: 1. save gas 2. more readable with custom error message 3. can be defined outside of contract
 */

contract CustomError {
    error InsufficientBalance();
    error InsufficientBalanceWithPara(uint256 requested, uint256 available);

    // 1. use custom error, 445 gas
    function withdraw1(uint256 _amount) public view {
        if (_amount > address(this).balance) {
            revert InsufficientBalance();
        }
    }

    // 2. use custom error with custom error message, 749 gas
    function withdraw2(uint256 _amount) public view {
        if (_amount > address(this).balance) {
            revert InsufficientBalanceWithPara({
                requested: _amount,
                available: address(this).balance
            });
        }
    }

    // 3. use require with short error message, 721 gas
    function withdraw3(uint256 _amount) public view {
        require(_amount <= address(this).balance, "Insufficient balance");
    }

    // 4. use require with long error message, 801 gas
    function withdraw4(uint256 _amount) public view {
        require(
            _amount <= address(this).balance,
            "Insufficient balance in withdraw, please send more ETH to this address before withdraw."
        );
    }
}
