// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

// import Foo.sol from current directory
import "./37.1_Import.sol";

// import {symbol1 as alias, symbol2} from "filename";
import {Unauthorized, add as func, Point} from "./37.1_Import.sol";

contract Import {
    // Initialize Foo.sol
    Foo public foo = new Foo();

    // Test Foo.sol by getting it's name.
    function getFooName() public view returns (string memory) {
        return foo.name();
    }
}
