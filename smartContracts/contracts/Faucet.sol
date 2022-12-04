// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract khaaliJaebFaucet {

    address private owner;
    uint public distAmt = 1000000000000000000;

    constructor() payable { owner = msg.sender; }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function.");
        _;
    }

    function deposit() public payable {}

    function withdraw(address payable _to) public onlyOwner {
      require(address(this).balance > distAmt, 'Insufficient balance in faucet');
      _to.transfer(distAmt);
    }
    
}