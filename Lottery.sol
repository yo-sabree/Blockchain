// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Lottery {

    address public manager;
    address payable[] public players;
    address payable public winner;

    constructor() {
        manager = msg.sender;
    }

    function participate() public payable  {
        require(msg.value==1 ether, "Player must pay 1 ETH");
        players.push(payable(msg.sender));
    }

    function getBalance() public view returns(uint){
        require(manager==msg.sender, "Only Manager can call the function");
        return address(this).balance;
    }
    
    function random() public view returns(uint){
        return uint(keccak256(abi.encodePacked(block.prevrandao, block.timestamp, players.length)));
    }

    function pickwinner() public{
        require(manager==msg.sender, "You must be manager to use this.");
        require(players.length>=3, "Must be minimum 3 players");

        uint r=random();
        uint index = r%players.length;
        winner = players[index];
        winner.transfer(getBalance());
        players = new address payable[](0);
    }
}