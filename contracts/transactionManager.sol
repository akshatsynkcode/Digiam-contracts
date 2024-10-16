// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TransactionManager {

    // Struct to represent a transaction with all fields as strings
    struct Transaction {
        string transactionId;              // Unique identifier for each transaction
        string userId;                     // ID of the user making the payment
        string moduleType;                 // The type of module where the transaction occurred (IAM, Warehouse, Booking)
        string moduleId;                   // The respective ID (e.g., service_id, warehouse_id, or booking_id)
        string amount;                     // The amount deducted for the transaction
        string createdAt;                  // Timestamp when the transaction was created
        string transferredWalletAddress;   // Wallet address to which the funds are transferred
    }

    // Mapping to store all transactions using transactionId as the key
    mapping(string => Transaction) public transactions;

    // Event for when a new transaction is created
    event TransactionCreated(
        string transactionId,
        string userId,
        string moduleType,
        string moduleId,
        string amount,
        string createdAt,
        string transferredWalletAddress
    );

    // Function to create a new transaction
    function createTransaction(
        string memory _transactionId,
        string memory _userId,
        string memory _moduleType,
        string memory _moduleId,
        string memory _amount,
        string memory _createdAt,
        string memory _transferredWalletAddress
    ) public {
        // Create a new transaction
        Transaction memory newTransaction = Transaction({
            transactionId: _transactionId,
            userId: _userId,
            moduleType: _moduleType,
            moduleId: _moduleId,
            amount: _amount,
            createdAt: _createdAt,
            transferredWalletAddress: _transferredWalletAddress
        });

        // Store the transaction
        transactions[_transactionId] = newTransaction;

        // Emit event
        emit TransactionCreated(
            _transactionId,
            _userId,
            _moduleType,
            _moduleId,
            _amount,
            _createdAt,
            _transferredWalletAddress
        );
    }

    // Function to retrieve a transaction by ID
    function getTransaction(string memory _transactionId) public view returns (Transaction memory) {
        return transactions[_transactionId];
    }
}

