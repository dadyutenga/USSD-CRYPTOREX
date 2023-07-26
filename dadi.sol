// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleWallet {
    address public owner;

    event Transfer(address indexed from, address indexed to, uint256 amount);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action");
        _;
    }

    function sendCrypto(address payable to) external payable {
        require(to != address(0), "Invalid recipient address");
        require(msg.value > 0, "Invalid amount");

        uint256 amountToSend = msg.value;
        require(address(this).balance >= amountToSend, "Insufficient balance");

        (bool success, ) = to.call{value: amountToSend}("");
        require(success, "Transfer failed");

        emit Transfer(msg.sender, to, amountToSend);
    }

    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }

    function withdrawFunds() external onlyOwner {
        require(address(this).balance > 0, "No funds to withdraw");
        
        uint256 amountToWithdraw = address(this).balance;
        (bool success, ) = msg.sender.call{value: amountToWithdraw}("");
        require(success, "Withdrawal failed");
    }
}
