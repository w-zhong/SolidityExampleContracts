/*
 This contract will demenstrate baic usage of Solidity.
    1. how to define a contract, state/local/global variable, function
    2. data types
        value: bool, address, int, uint, fixed, ufixed, bytes, string, enum, function
        reference: array, struct, mapping
    3. data location
        storage, memory, calldata
    4. data modifiers
        constant, immutable
    5. function modifiers
        visibility: public, private, internal, external
        mutability: pure, view, payable
    6. sate variable is stored in contract storage, local variable is stored in memory
    7. global variable: msg, block, tx, abi, type, selfdestruct
    8. function modifier
    9. mapping
    10. struct, enum
 */

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract HelloSolidity {
    // state variable is defined outside of function
    string public sateVariable = "Hello World";
    // constant variable can not be modified
    string public constant CONSTANT_STATEVARIABLE = "Hello Satoshi";
    // unfix size array
    uint256[] public unfixArray = [1, 2, 3];
    // fix size array
    uint256[3] public fixArray = [1, 2, 3];

    // immutable can only be set once with constructor
    address public immutable I_OWNER;

    // constructor is used to initialise the contract parameter
    // constructor called once when contract is deployed
    constructor() {
        I_OWNER = msg.sender;
    }

    // public function can be called by anyone
    // payable function can receive ETH
    function setSateVariable(string memory _message) public payable {
        sateVariable = _message;
    }

    // local variable is defined inside of function, it will be deleted after function execution
    // external function can only be called by external contract
    // pure function does not read or modify the state
    function add(uint256 _a, uint256 _b) external pure returns (uint256) {
        uint256 localVariable = _a + _b;
        return localVariable;
    }

    // global variable is defined in Solidity
    // internal function can only be called by current contract or contract that inherit current contract
    // view function only read the state but does not modify the state
    function getGlobalVariable() internal view returns (address) {
        return msg.sender;
    }

    // private function can only be called by current contract, e.g. callPrivateFunc()
    function privateFunc() private view returns (address) {
        return msg.sender;
    }

    // the purpuse of this function is to call private function privateFunc() above
    function callPrivateFunc() public view returns (address) {
        return privateFunc();
    }

    // create a function modifier onlyOwner and use it in function onlyOwnerFunc()
    modifier onlyOwner() {
        require(msg.sender == I_OWNER, "Only owner can call this function");
        _;
    }

    function onlyOwnerFunc() public view onlyOwner returns (address) {
        return msg.sender;
    }

    // array modify function from [1, 2, 3]
    function arrayModify() public {
        // [1, 2, 3, 4]
        unfixArray.push(4);
        // [1, 2, 3]
        unfixArray.pop();
        // [1, 0, 3]
        // only reset the value to default, not delete the element
        delete unfixArray[1];
        // [1, 5, 3]
        unfixArray[1] = 5;
    }

    // mapping is a key-value store in Solidity
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => bool)) public isFriend;

    function mappingFunc() public {
        // set balance
        balanceOf[msg.sender] = 100;
        // set isFriend
        isFriend[msg.sender][address(this)] = true;

        // delete
        delete balanceOf[msg.sender];
    }

    // struct is a custom data type, order doen't matter
    struct Car {
        string model;
        uint256 year;
        address owner;
    }
    Car public car;
    Car[] public cars;
    mapping(address => Car[]) public carsByOwner;
    Car public myCar2;

    function structFunc() public {
        // create a new car
        Car memory myCar = Car("BMW", 2021, msg.sender);
        // set car
        car = myCar;
        // add car to cars array
        cars.push(myCar);
        // add car to carsByOwner mapping
        carsByOwner[msg.sender].push(myCar);

        myCar2.model = "Audi";
        myCar2.year = 2021;
        myCar2.owner = msg.sender;
    }

    // enum is a custom data type, order matters
    enum Status {
        None,
        Pending,
        Shipped
    }
    Status public status;
    struct Order {
        address buyer;
        Status status;
    }

    Order[] public orders;

    function getEnumValue() public view returns (Status) {
        return status;
    }

    function enumFunc() public {
        // set status
        status = Status.None;
        // create a new order
        Order memory order = Order(msg.sender, Status.Pending);
        // add order to orders array
        orders.push(order);
    }
}
