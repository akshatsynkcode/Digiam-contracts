// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DubuyOrderAndTransaction {
    address public owner;
    uint128 public contractBalance;
    address public toAddress;
    address public fromAddress;

    // Struct to store booking details
    struct BookingDetails {
        string fromWalletAddress;
        string toWalletAddress;
        string transactionId;
        string invoiceId; // Used as both invoiceId and moduleId
        string amount;
        string moduleType;
    }

    // Mapping of transactionId to BookingDetails
    mapping(string => BookingDetails) public bookings;

    event BookingCreated(string bookingId);
    event FundsTransferred(address to, uint128 amount, string status);

    modifier onlyOwner() {
        require(msg.sender == owner, "Caller is not the owner");
        _;
    }

    // Constructor to initialize the contract with owner and addresses
    constructor(
        address _owner,
        address _toAddress, 
        address _fromAddress
    ) {
        owner = _owner;
        toAddress = _toAddress;
        fromAddress = _fromAddress;
        contractBalance = 0;
    }

    // Anyone can call this function to create a booking
    function createBooking(
        string memory _fromWalletAddress,
        string memory _toWalletAddress,
        string memory _transactionId,
        string memory _invoiceId, // Used as both invoiceId and moduleId
        string memory _amount,
        string memory _moduleType
    ) public {
        // Create a new booking
        BookingDetails memory newBooking = BookingDetails({
            fromWalletAddress: _fromWalletAddress,
            toWalletAddress: _toWalletAddress,
            transactionId: _transactionId,
            invoiceId: _invoiceId,
            amount: _amount,
            moduleType: _moduleType
        });

        // Save the booking in the mapping using transactionId as the key
        bookings[_transactionId] = newBooking;

        // Emit event
        emit BookingCreated(_transactionId);
    }

    // Function to deposit funds into the contract
    function depositFunds() external payable {
        contractBalance += uint128(msg.value);
    }

    // Only the owner can call this function to transfer funds based on booking status
    function transferBasedOnStatus(string memory status) external onlyOwner {
        require(contractBalance > 0, "No funds available to transfer");
        
        address payable recipient;
        
        // Determine recipient based on booking status
        if (keccak256(abi.encodePacked(status)) == keccak256(abi.encodePacked("accepted"))) {
            recipient = payable(toAddress);
        } else if (keccak256(abi.encodePacked(status)) == keccak256(abi.encodePacked("rejected"))) {
            recipient = payable(fromAddress);
        } else {
            revert("Invalid status");
        }

        // Transfer funds to the recipient
        recipient.transfer(contractBalance);

        // Emit funds transfer event
        emit FundsTransferred(recipient, contractBalance, status);

        // Reset contract balance to 0 after transfer
        contractBalance = 0;
    }

    // Function to get booking details by transactionId
    function getBookingDetails(string memory transactionId) public view returns (BookingDetails memory) {
        return bookings[transactionId];
    }

    // Function to get the current contract balance
    function getContractBalance() external view returns (uint128) {
        return contractBalance;
    }
}
