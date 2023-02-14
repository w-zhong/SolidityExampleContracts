// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/*
An error will undo all changes made to the state during a transaction.
You can throw an error by calling require, revert or assert.
    require is used to validate inputs and conditions before execution.
    revert is similar to require. See the code below for details.
    assert is used to check for code that should never be false. Failing assertion probably means that there is a bug.
Use custom error to save gas.
*/

contract Error {
    function testRequire(uint256 _i) public pure {
        // Require should be used to validate conditions such as:
        // - inputs
        // - conditions before execution
        // - return values from calls to other functions
        require(_i > 10, "Input must be greater than 10");
    }

    function testRevert(uint256 _i) public pure {
        // Revert is useful when the condition to check is complex.
        // This code does the exact same thing as the example above
        if (_i <= 10) {
            revert("Input must be greater than 10");
        }
    }

    uint256 public num;

    function testAssert() public view {
        // Assert should only be used to test for internal errors and to check invariants.

        // Here we assert that num is always equal to 0 since it is impossible to update the value of num
        assert(num == 0);
    }

    // custom error
    error InsufficientBalance(uint256 balance, uint256 withdrawAmount);

    function testCustomError(uint256 _withdrawAmount) public view {
        uint256 bal = address(this).balance;
        if (bal < _withdrawAmount) {
            revert InsufficientBalance({
                balance: bal,
                withdrawAmount: _withdrawAmount
            });
        }
    }
}

// Another example.
contract Account {
    uint256 public balance;
    uint256 public constant MAX_UINT = 2**256 - 1;

    function deposit(uint256 _amount) public {
        uint256 oldBalance = balance;
        uint256 newBalance = balance + _amount;

        // balance + _amount does not overflow if balance + _amount >= balance
        require(newBalance >= oldBalance, "Overflow");

        balance = newBalance;

        assert(balance >= oldBalance);
    }

    function withdraw(uint256 _amount) public {
        uint256 oldBalance = balance;

        // balance - _amount does not underflow if balance >= _amount
        require(balance >= _amount, "Underflow");

        if (balance < _amount) {
            revert("Underflow");
        }

        balance -= _amount;

        assert(balance <= oldBalance);
    }
}

/**
 Since Solidity 0.8, custom error is defined.
 Benefit: 1. save gas 2. more readable with custom error message 3. can be defined outside of contract
 */
contract CustomError {
    error InsufficientBalance();
    error InsufficientBalanceWithPara(uint256 requested, uint256 available);

    // 1. custom error, 445 gas
    function withdraw1(uint256 _amount) public view {
        if (_amount > address(this).balance) {
            revert InsufficientBalance();
        }
    }

    // 2. custom error with custom error message, 749 gas
    function withdraw2(uint256 _amount) public view {
        if (_amount > address(this).balance) {
            revert InsufficientBalanceWithPara({
                requested: _amount,
                available: address(this).balance
            });
        }
    }

    // 3. require with short error message, 721 gas
    function withdraw3(uint256 _amount) public view {
        require(_amount <= address(this).balance, "Insufficient balance");
    }

    // 4. require with long error message, 801 gas
    function withdraw4(uint256 _amount) public view {
        require(
            _amount <= address(this).balance,
            "Insufficient balance in withdraw, please send more ETH to this address before withdraw."
        );
    }
}
