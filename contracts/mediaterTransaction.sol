// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract mediaterTransaction {
    uint256 public contractBalance;
    address public toAddress;
    address public fromAddress;

    // String fields for detailed transaction tracking
    string public transactionId;
    string public status;
    string public moduleType;
    string public moduleId;
    string public uniqueId;

    // Constructor to set the initial values including new string fields
    constructor(
        address _toAddress, 
        address _fromAddress, 
        string memory _transactionId, 
        string memory _status, 
        string memory _moduleType, 
        string memory _moduleId, 
        string memory _uniqueId
    ) {
        toAddress = _toAddress;
        fromAddress = _fromAddress;
        contractBalance = 0;
        transactionId = _transactionId;
        status = _status;
        moduleType = _moduleType;
        moduleId = _moduleId;
        uniqueId = _uniqueId;
    }

    // Function to deposit funds into the contract
    function depositFunds() external payable {
        contractBalance += msg.value;
    }

    // Function to transfer funds based on transaction status
    function transferBasedOnStatus(bool statusFlag) external {
        uint256 amount = contractBalance;
        require(amount > 0, "No funds available to transfer");

        address payable recipient = statusFlag ? payable(toAddress) : payable(fromAddress);
        recipient.transfer(amount);
        contractBalance = 0;  // Reset the contract balance to 0
    }

    // Function to update string fields
    function updateTransactionDetails(
        string memory _transactionId, 
        string memory _status, 
        string memory _moduleType, 
        string memory _moduleId, 
        string memory _uniqueId
    ) external {
        transactionId = _transactionId;
        status = _status;
        moduleType = _moduleType;
        moduleId = _moduleId;
        uniqueId = _uniqueId;
    }

    // Function to get all transaction details
    function getTransactionDetails() external view returns (
        uint256 balance,
        address toAddr,
        address fromAddr,
        string memory currentTransactionId,
        string memory currentStatus,
        string memory currentModuleType,
        string memory currentModuleId,
        string memory currentUniqueId
    ) {
        return (
            contractBalance,
            toAddress,
            fromAddress,
            transactionId,
            status,
            moduleType,
            moduleId,
            uniqueId
        );
    }

    // Function to check the contract balance
    function getContractBalance() external view returns (uint256) {
        return contractBalance;
    }
}
