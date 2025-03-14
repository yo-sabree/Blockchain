// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CompleteSolidity {
    // State Variables (Stored on Blockchain)
    uint public stateNumber;
    string public stateText;
    bool public stateBoolean;
    address public owner;
    
    // Arrays
    uint[] public dynamicArray;
    uint[5] public fixedArray = [1, 2, 3, 4, 5];

    // Mappings
    mapping(address => uint) public balances;
    mapping(uint => Student) public students;

    // Structs (Custom Data Types)
    struct Student {
        string name;
        uint rollNo;
        bool isPassed;
    }

    // Modifier
    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    // Constructor (Runs only once when contract is deployed)
    constructor(uint _num, string memory _text, bool _flag) {
        owner = msg.sender;
        stateNumber = _num;
        stateText = _text;
        stateBoolean = _flag;
    }

    // State Variable Setter
    function setStateValues(uint _num, string memory _text, bool _flag) public onlyOwner {
        stateNumber = _num;
        stateText = _text;
        stateBoolean = _flag;
    }

    // Local Variable Example (Does not modify blockchain storage)
    function addNumbers(uint a, uint b) public pure returns (uint) {
        uint localSum = a + b;
        return localSum;
    }

    // Dynamic Array Operations
    function addToArray(uint _num) public {
        dynamicArray.push(_num);
    }

    function getArrayLength() public view returns (uint) {
        return dynamicArray.length;
    }

    function getArrayElement(uint index) public view returns (uint) {
        require(index < dynamicArray.length, "Index out of bounds");
        return dynamicArray[index];
    }

    // Mapping Operations
    function depositBalance() public payable {
        balances[msg.sender] += msg.value;
    }

    function getBalance(address _user) public view returns (uint) {
        return balances[_user];
    }

    // Struct Operations
    function addStudent(uint _rollNo, string memory _name, bool _pass) public {
        students[_rollNo] = Student(_name, _rollNo, _pass);
    }

    function getStudent(uint _rollNo) public view returns (string memory, uint, bool) {
        Student memory s = students[_rollNo];
        return (s.name, s.rollNo, s.isPassed);
    }

    // Only Owner Can Withdraw Funds
    function withdraw(uint _amount) public onlyOwner {
        require(address(this).balance >= _amount, "Insufficient balance");
        payable(owner).transfer(_amount);
    }
}
