// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract WarehouseBookingAndTransactions {
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
        string status; // Status of the booking
        string comment;
    }

    uint128 public contractBalance;  // Use uint128 to comply with Substrate's integer size
    address public toAddress;
    address public fromAddress;
    mapping(string => BookingDetails) public bookings;

    string public transactionId;
    string public moduleType;
    string public moduleId;
    string public uniqueId;
    string public bookingStatus; // Separate status to avoid shadowing and confusion

    event BookingCreated(string bookingId);

    constructor(
        address _toAddress, 
        address _fromAddress,
        string memory _transactionId,
        string memory _bookingStatus,
        string memory _moduleType,
        string memory _moduleId,
        string memory _uniqueId
    ) {
        toAddress = _toAddress;
        fromAddress = _fromAddress;
        contractBalance = 0;
        transactionId = _transactionId;
        bookingStatus = _bookingStatus; // Ensure no shadowing occurs
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

    function transferBasedOnStatus(bool statusFlag) external {
        require(contractBalance > 0, "No funds available to transfer");

        address payable recipient = statusFlag ? payable(toAddress) : payable(fromAddress);
        recipient.transfer(contractBalance);
        contractBalance = 0; // Reset the contract balance to 0
    }

    function getBookingDetails(string memory bookingId) public view returns (BookingDetails memory) {
        return bookings[bookingId];
    }

    function getContractBalance() external view returns (uint128) {
        return contractBalance;
    }
}
