// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Booking {
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
        string status;  // Status as a simple text string
        string comment;
    }

    // A mapping to store booking details by booking ID
    mapping(string => BookingDetails) public bookings;

    // Event to emit when a new booking is created
    event BookingCreated(string bookingId);

    // Function to create a new booking
    function createBooking(
        string memory _warehouseId,
        string memory _bookingId,
        string memory _orderNo,
        string memory _price,
        string memory _customerName,
        string memory _customerEmailId,
        string memory _totalBookedArea,
        string memory _bookingPeriod,
        string memory _warehouseName,
        string memory _totalArea,
        string memory _isBonded,
        string memory _warehouseAddress,
        string memory _status,
        string memory _comment
    ) public {
        bookings[_bookingId] = BookingDetails(
            _warehouseId,
            _bookingId,
            _orderNo,
            _price,
            _customerName,
            _customerEmailId,
            _totalBookedArea,
            _bookingPeriod,
            _warehouseName,
            _totalArea,
            _isBonded,
            _warehouseAddress,
            _status,
            _comment
        );

        // Emit the event
        emit BookingCreated(_bookingId);
    }

    // Function to retrieve booking details by booking ID
    function getBooking(string memory _bookingId) public view returns (BookingDetails memory) {
        return bookings[_bookingId];
    }
}
