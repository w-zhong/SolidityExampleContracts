// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract DataTypes {
    bool public myBool = true;

    uint8 public myUint8 = 1;
    uint256 public myUint256 = 10000;

    int8 public myInt8 = -1;
    int256 public myInt256 = -100;

    int256 public minInt = type(int256).min;
    int256 public maxInt = type(int256).max;

    address public myAddress = 0xEfaEf44569A417844cacE997715186436D010A47;

    bytes1 a = 0xb5;
    bytes1 b = 0x56;

    // default values
    bool public defaultBool; // false
    uint256 public defaultUint256; // 0
    int256 public defaultInt256; // 0
    address public defaultAddress; // 0x0000000000000000000000000000000000000000
    bytes public defaultBytes; // 0x
    string public defaultString; // “”
    enum defaultEnum {
        a
    } // the first element of the enum
    struct defaultStruct {
        uint256 a;
    } // {a: 0} (all fields are default values)
    uint256[] defaultArray; // [] (empty array)
    uint256[3] defaultFixedArray; // [0, 0, 0] (all elements are default values)
}
