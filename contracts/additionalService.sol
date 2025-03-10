// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CreateService {
    address public owner;
    uint128 public contractBalance;
    address public toAddress;
    address public fromAddress;

    // Struct to store service details
    struct ServiceDetails {
        string serviceId;
        string bookingId;
        string orderNo;
        string price;
        string customerName;
        string customerEmailId;
        string servicePeriod;
        string serviceName;
        string serviceLocation;
        string status;
    }

    // Mapping of serviceId to ServiceDetails
    mapping(string => ServiceDetails) public services;

    event ServiceCreated(string serviceId);
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

    // Anyone can call this function to create a service
    function createService(
        string memory _serviceId,
        string memory _bookingId,
        string memory _orderNo,
        string memory _price,
        string memory _customerName,
        string memory _customerEmailId,
        string memory _servicePeriod,
        string memory _serviceName,
        string memory _serviceLocation,
        string memory _status
    ) public {
        // Create a new service
        ServiceDetails memory newService = ServiceDetails({
            serviceId: _serviceId,
            bookingId: _bookingId,
            orderNo: _orderNo,
            price: _price,
            customerName: _customerName,
            customerEmailId: _customerEmailId,
            servicePeriod: _servicePeriod,
            serviceName: _serviceName,
            serviceLocation: _serviceLocation,
            status: _status
        });

        // Save the service in the mapping using serviceId as the key
        services[_serviceId] = newService;

        // Emit event
        emit ServiceCreated(_serviceId);
    }

    // Function to deposit funds into the contract
    function depositFunds() external payable {
        contractBalance += uint128(msg.value);
    }

    // Only the owner can call this function to transfer funds based on booking status
    function transferBasedOnStatus(string memory status) external onlyOwner {
        require(contractBalance > 0, "No funds available to transfer");
        
        address payable recipient;
        
        // Determine recipient based on service status
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

    // Function to get service details by serviceId
    function getServiceDetails(string memory serviceId) public view returns (ServiceDetails memory) {
        return services[serviceId];
    }

    // Function to get the current contract balance
    function getContractBalance() external view returns (uint128) {
        return contractBalance;
    }
}
