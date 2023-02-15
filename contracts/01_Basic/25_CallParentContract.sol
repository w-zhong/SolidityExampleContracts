// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/* 

Parent contracts can be called directly, or by using the keyword 'super'.
By using the keyword 'super', all of the immediate parent contracts will be called.

Inheritance tree
   A
 /  \
B   C
 \ /
  D
*/

contract A {
    event Log(string message);

    // A.foo called
    function foo() public virtual {
        emit Log("A.foo called");
    }

    // A.bar called
    function bar() public virtual {
        emit Log("A.bar called");
    }
}

contract B is A {
    // B.foo called
    // A.foo called
    function foo() public virtual override {
        emit Log("B.foo called");
        A.foo();
    }

    // B.bar called
    // A.bar called
    function bar() public virtual override {
        emit Log("B.bar called");
        // A.bar
        super.bar();
    }
}

contract C is A {
    // C.foo called
    // A.foo called
    function foo() public virtual override {
        emit Log("C.foo called");
        A.foo();
    }

    // C.bar called
    // A.bar called
    function bar() public virtual override {
        emit Log("C.bar called");
        // A.bar
        super.bar();
    }
}

contract D is B, C {
    /*
    Solidity reads first contract B, and it writes foo() function in a temp file.
    Then it reads C contract, it sees the same foo() function and overwrite it. 
    Then it reads D contract, it finds another foo() function but this time 
    it does NOT overwrite the existing function because the called D.foo() contain a super keyword.
    So both functions survive in the final contract, and they are called when you call D.foo().
     */

    // C.foo called
    // A.foo called
    function foo() public override(B, C) {
        super.foo();
    }

    // C.bar called
    // B.bar called
    // A.bar called
    function bar() public override(B, C) {
        super.bar();
    }
}
