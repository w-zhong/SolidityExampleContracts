// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

// You can define your own type by creating a struct. They are useful for grouping together related data.
// Structs can be declared outside of a contract and imported in another contract.

contract Todos {
    struct Todo {
        string text;
        bool completed;
    }

    // An array of 'Todo' structs
    Todo[] public todos;

    function create(string calldata _text) public {
        // Three ways to initialize a struct
        // 1. calling it like a function
        todos.push(Todo(_text, false));

        // 2. key value mapping
        todos.push(Todo({text: _text, completed: false}));

        // 3. initialize an empty struct and then update it
        Todo memory todo;
        todo.text = _text;
        // todo.completed initialized to false

        todos.push(todo);
    }

    // update text
    function updateText(uint256 _index, string calldata _text) public {
        Todo storage todo = todos[_index];
        todo.text = _text;
    }

    // update completed
    function toggleCompleted(uint256 _index) public {
        Todo storage todo = todos[_index];
        todo.completed = !todo.completed;
    }
}

// Struct can be declared outside a contract or in a sperate file.
// If the following is saved in 'StructDeclaration.sol'.
// Then you can import it into your contract with <import "./StructDeclaration.sol";>.
struct Todo1 {
    string text;
    bool completed;
}
