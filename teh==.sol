// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ChainlinkOracle {
    address public owner;
    uint256 public ussdData;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action");
        _;
    }

    function updateUSSDData(uint256 newData) external onlyOwner {
        ussdData = newData;
    }
}
