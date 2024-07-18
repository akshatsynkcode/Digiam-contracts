// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Warehouse {
    // Struct to store information about each warehouse
    struct WarehouseInfo {
        string warehouseId; // Unique identifier for the warehouse
        string userWalletAddress; // Wallet address of the user (stored as a string)
        string warehouseName; // Name of the warehouse
        string warehouseType; // Type of the warehouse
        string area; // Area of the warehouse
        string warehouseAddressLine1; // First line of the warehouse address
        string warehouseAddressLine2; // Second line of the warehouse address (optional)
        string emirate; // Emirate of the warehouse location
        string poBoxNumber; // PO Box number of the warehouse
        string makaniNumber; // Makani number of the warehouse
        string storageCommodities; // Types of commodities stored in the warehouse
        string storageTypes; // Types of storage available in the warehouse
        string storageRestrictions; // Restrictions on storage in the warehouse
        string totalAvailableSpace; // Total available space in the warehouse (stored as a string)
        string firstName; // First name of the warehouse manager/contact person
        string lastName; // Last name of the warehouse manager/contact person
        string emailId; // Email ID of the warehouse manager/contact person
        string mobileNumber; // Mobile number of the warehouse manager/contact person
        string landlineNumber; // Landline number of the warehouse (if any)
        string designation; // Designation of the warehouse manager/contact person
        string documentType; // Type of document provided for verification
        string documentUrl; // URL to the document provided for verification
        string state; // Current state of the warehouse
    }

    // Mapping to store warehouses using their ID as the key
    mapping(string => WarehouseInfo) public warehouses;
    uint256 public warehouseCount; // Counter to keep track of the number of warehouses

    // Events to be emitted when a warehouse is created or its state is changed
    event WarehouseCreated(string warehouseId, string warehouseName, string warehouseType);
    event WarehouseStateChanged(string warehouseId, string state);

    /**
     * @dev Creates a new warehouse entry with the provided details.
     * @param _warehouseId Unique ID for the warehouse.
     * @param _userWalletAddress Wallet address of the user creating the warehouse entry.
     * @param _warehouseName Name of the warehouse.
     * @param _warehouseType Type of the warehouse.
     * @param _area Area of the warehouse.
     * @param _warehouseAddressLine1 First line of the warehouse address.
     * @param _warehouseAddressLine2 Second line of the warehouse address (optional).
     * @param _emirate Emirate of the warehouse location.
     * @param _poBoxNumber PO Box number of the warehouse.
     * @param _makaniNumber Makani number of the warehouse.
     * @param _storageCommodities Types of commodities stored in the warehouse.
     * @param _storageTypes Types of storage available in the warehouse.
     * @param _storageRestrictions Restrictions on storage in the warehouse.
     * @param _totalAvailableSpace Total available space in the warehouse (as a string).
     * @param _firstName First name of the warehouse manager/contact person.
     * @param _lastName Last name of the warehouse manager/contact person.
     * @param _emailId Email ID of the warehouse manager/contact person.
     * @param _mobileNumber Mobile number of the warehouse manager/contact person.
     * @param _landlineNumber Landline number of the warehouse (if any).
     * @param _designation Designation of the warehouse manager/contact person.
     * @param _documentType Type of document provided for verification.
     * @param _documentUrl URL to the document provided for verification.
     */
    function createWarehouse(
        string memory _warehouseId,
        string memory _userWalletAddress, // Expecting wallet address as a string
        string memory _warehouseName,
        string memory _warehouseType,
        string memory _area,
        string memory _warehouseAddressLine1,
        string memory _warehouseAddressLine2,
        string memory _emirate,
        string memory _poBoxNumber,
        string memory _makaniNumber,
        string memory _storageCommodities,
        string memory _storageTypes,
        string memory _storageRestrictions,
        string memory _totalAvailableSpace, // Expect value as a string (e.g., "123.45")
        string memory _firstName,
        string memory _lastName,
        string memory _emailId,
        string memory _mobileNumber,
        string memory _landlineNumber,
        string memory _designation,
        string memory _documentType,
        string memory _documentUrl
    ) public {
        // Validate input parameters to ensure they are not empty
        require(bytes(_warehouseId).length > 0, "Warehouse ID cannot be empty");
        require(bytes(_userWalletAddress).length > 0, "User wallet address cannot be empty");
        require(bytes(_warehouseName).length > 0, "Warehouse name cannot be empty");
        require(bytes(_warehouseType).length > 0, "Warehouse type cannot be empty");
        require(bytes(_area).length > 0, "Area cannot be empty");
        require(bytes(_warehouseAddressLine1).length > 0, "Warehouse address line 1 cannot be empty");
        require(bytes(_emirate).length > 0, "Emirate cannot be empty");
        require(bytes(_poBoxNumber).length > 0, "PO Box number cannot be empty");
        require(bytes(_firstName).length > 0, "First name cannot be empty");
        require(bytes(_lastName).length > 0, "Last name cannot be empty");
        require(bytes(_emailId).length > 0, "Email ID cannot be empty");
        require(bytes(_mobileNumber).length > 0, "Mobile number cannot be empty");
        require(bytes(warehouses[_warehouseId].warehouseId).length == 0, "Warehouse ID already exists");

        // If warehouseAddressLine2 is an empty string, assign a default value
        if (bytes(_warehouseAddressLine2).length == 0) {
            _warehouseAddressLine2 = ""; // Assign default value or leave it as an empty string
        }

        // Create a new warehouse entry and store it in the mapping
        warehouses[_warehouseId] = WarehouseInfo({
            warehouseId: _warehouseId,
            userWalletAddress: _userWalletAddress, // Store as string
            warehouseName: _warehouseName,
            warehouseType: _warehouseType,
            area: _area,
            warehouseAddressLine1: _warehouseAddressLine1,
            warehouseAddressLine2: _warehouseAddressLine2,
            emirate: _emirate,
            poBoxNumber: _poBoxNumber,
            makaniNumber: _makaniNumber,
            storageCommodities: _storageCommodities,
            storageTypes: _storageTypes,
            storageRestrictions: _storageRestrictions,
            totalAvailableSpace: _totalAvailableSpace, // Store as a string
            firstName: _firstName,
            lastName: _lastName,
            emailId: _emailId,
            mobileNumber: _mobileNumber,
            landlineNumber: _landlineNumber,
            designation: _designation,
            documentType: _documentType,
            documentUrl: _documentUrl,
            state: "UnderProcess" // Default state is UnderProcess
        });

        warehouseCount++; // Increment the warehouse count

        // Emit an event to indicate a new warehouse has been created
        emit WarehouseCreated(_warehouseId, _warehouseName, _warehouseType);
    }

    /**
     * @dev Changes the state of an existing warehouse.
     * @param _warehouseId ID of the warehouse to change the state.
     * @param _state New state to set for the warehouse.
     */
    function changeWarehouseState(string memory _warehouseId, string memory _state) public {
        // Validate that the warehouse ID is not empty
        require(bytes(_warehouseId).length > 0, "Warehouse ID cannot be empty");
        // Validate that the warehouse exists
        require(bytes(warehouses[_warehouseId].warehouseId).length != 0, "Warehouse does not exist");

        // Update the state of the warehouse
        warehouses[_warehouseId].state = _state;

        // Emit an event to indicate the warehouse state has been changed
        emit WarehouseStateChanged(_warehouseId, _state);
    }

    function getWarehouse(string memory _warehouseId) public view returns (
        string memory warehouseId,
        string memory userWalletAddress,
        string memory warehouseName,
        string memory warehouseType,
        string memory area,
        string memory warehouseAddressLine1,
        string memory warehouseAddressLine2,
        string memory emirate,
        string memory poBoxNumber,
        string memory makaniNumber,
        string memory storageCommodities,
        string memory storageTypes,
        string memory storageRestrictions,
        string memory totalAvailableSpace,
        string memory firstName,
        string memory lastName,
        string memory emailId,
        string memory mobileNumber,
        string memory landlineNumber,
        string memory designation,
        string memory documentType,
        string memory documentUrl,
        string memory state
    ) {
        // Validate that the warehouse ID is not empty
        require(bytes(_warehouseId).length > 0, "Warehouse ID cannot be empty");
        // Validate that the warehouse exists
        require(bytes(warehouses[_warehouseId].warehouseId).length != 0, "Warehouse does not exist");

        WarehouseInfo storage warehouse = warehouses[_warehouseId];
        return (
            warehouse.warehouseId,
            warehouse.userWalletAddress,
            warehouse.warehouseName,
            warehouse.warehouseType,
            warehouse.area,
            warehouse.warehouseAddressLine1,
            warehouse.warehouseAddressLine2,
            warehouse.emirate,
            warehouse.poBoxNumber,
            warehouse.makaniNumber,
            warehouse.storageCommodities,
            warehouse.storageTypes,
            warehouse.storageRestrictions,
            warehouse.totalAvailableSpace,
            warehouse.firstName,
            warehouse.lastName,
            warehouse.emailId,
            warehouse.mobileNumber,
            warehouse.landlineNumber,
            warehouse.designation,
            warehouse.documentType,
            warehouse.documentUrl,
            warehouse.state
        );
    }
}
