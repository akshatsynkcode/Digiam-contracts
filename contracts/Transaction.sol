// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Transaction {
    address public owner;
    uint256 public contractBalance;

    // Modifier to restrict function access to only the owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can execute this function");
        _;
    }

    // Constructor to set the contract deployer as the owner
    constructor() {
        owner = msg.sender;
        contractBalance = 0;
    }

    // Deposit function to store funds in the contract
    function depositFunds() external payable {
        contractBalance += msg.value;
    }

    // Function to transfer balance back to the owner (admin)
    function transferToAdmin() external onlyOwner {
        uint256 amount = contractBalance;
        require(amount > 0, "No funds available to transfer");

        // Transfer the full balance to the owner
        payable(owner).transfer(amount);

        contractBalance = 0;  // Reset the contract balance to 0
    }

    // Function to transfer balance to a specific user address
    function transferToUser(address payable user) external onlyOwner {
        uint256 amount = contractBalance;
        require(amount > 0, "No funds available to transfer");

        // Transfer the full balance to the specified user address
        user.transfer(amount);

        contractBalance = 0;  // Reset the contract balance to 0
    }

    // Function to check the contract balance
    function getContractBalance() external view returns (uint256) {
        return contractBalance;
    }
}
