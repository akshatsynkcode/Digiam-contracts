// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract WarehouseBookingAndTransactions {
    address public owner;
    struct BookingDetails {
        string warehouseId;
        string bookingId;
        string orderNo;
        string price;
        string customerName;
        string customerEmailId;
        string totalBookedArea;
        string bookingPeriod;
        string warehouseName;
        string totalArea;
        string isBonded;
        string warehouseAddress;
        string status;
        string comment;
    }

    uint128 public contractBalance;
    address public toAddress;
    address public fromAddress;
    mapping(string => BookingDetails) public bookings;

    string public transactionId;
    string public moduleType;
    string public moduleId;
    string public uniqueId;
    string public bookingStatus;

    event BookingCreated(string bookingId);
    event FundsTransferred(address to, uint128 amount, string status);

    modifier onlyOwner() {
        require(msg.sender == owner, "Caller is not the owner");
        _;
    }

    constructor(
        address _owner,
        address _toAddress, 
        address _fromAddress,
        string memory _transactionId,
        string memory _bookingStatus,
        string memory _moduleType,
        string memory _moduleId,
        string memory _uniqueId
    ) {
        owner = _owner;
        toAddress = _toAddress;
        fromAddress = _fromAddress;
        contractBalance = 0;
        transactionId = _transactionId;
        bookingStatus = _bookingStatus;
        moduleType = _moduleType;
        moduleId = _moduleId;
        uniqueId = _uniqueId;
    }

    function createBooking(
        string memory warehouseId,
        string memory bookingId,
        string memory orderNo,
        string memory price,
        string memory customerName,
        string memory customerEmailId,
        string memory totalBookedArea,
        string memory bookingPeriod,
        string memory warehouseName,
        string memory totalArea,
        string memory isBonded,
        string memory warehouseAddress,
        string memory status,
        string memory comment
    ) public {
        BookingDetails memory newBooking = BookingDetails({
            warehouseId: warehouseId,
            bookingId: bookingId,
            orderNo: orderNo,
            price: price,
            customerName: customerName,
            customerEmailId: customerEmailId,
            totalBookedArea: totalBookedArea,
            bookingPeriod: bookingPeriod,
            warehouseName: warehouseName,
            totalArea: totalArea,
            isBonded: isBonded,
            warehouseAddress: warehouseAddress,
            status: status,
            comment: comment
        });
        bookings[bookingId] = newBooking;
        emit BookingCreated(bookingId);
    }

    function depositFunds() external payable {
        contractBalance += uint128(msg.value);
    }

    function transferBasedOnStatus(string memory status) external onlyOwner {
        require(contractBalance > 0, "No funds available to transfer");
        address payable recipient;

        if (keccak256(abi.encodePacked(status)) == keccak256(abi.encodePacked("accepted"))) {
            recipient = payable(toAddress);
        } else if (keccak256(abi.encodePacked(status)) == keccak256(abi.encodePacked("rejected"))) {
            recipient = payable(fromAddress);
        } else {
            revert("Invalid status");
        }

        recipient.transfer(contractBalance);
        emit FundsTransferred(recipient, contractBalance, status);
        contractBalance = 0; // Reset the contract balance to 0
    }

    function getBookingDetails(string memory bookingId) public view returns (BookingDetails memory) {
        return bookings[bookingId];
    }

    function getContractBalance() external view returns (uint128) {
        return contractBalance;
    }
}
