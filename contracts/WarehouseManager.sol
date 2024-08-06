// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Warehouse {
    // Struct to store information about each warehouse
    struct WarehouseInfo {
        string warehouseId;            // Unique identifier for the warehouse
        string userWalletAddress;      // Wallet address of the user (stored as a string)
        string warehouseName;          // Name of the warehouse
        string warehouseType;          // Type of the warehouse
        string area;                   // Area of the warehouse
        string warehouseAddressLine1;  // First line of the warehouse address
        string warehouseAddressLine2;  // Second line of the warehouse address (optional)
        string emirate;                // Emirate of the warehouse location
        string poBoxNumber;            // PO Box number of the warehouse
        string makaniNumber;           // Makani number of the warehouse
        string storageCommodities;     // Types of commodities stored in the warehouse
        string storageTypes;           // Types of storage available in the warehouse
        string storageRestrictions;    // Restrictions on storage in the warehouse
        string totalAvailableSpace;    // Total available space in the warehouse (stored as a string)
        string documents;              // Documents provided for verification
        string state;                  // Current state of the warehouse
        string images;                 // Image URLs of the warehouse
        string properties;             // Properties of the warehouse
        string iamUserId;            // IAM user ID associated with the warehouse
        string description;            // Description of the warehouse
        string coordinates;            // Coordinates of the warehouse location
        string price;                  // Price associated with the warehouse
        string country;                // Country of the warehouse location
        string city;                   // City of the warehouse location
    }

    // Mapping to store warehouses using their ID as the key
    mapping(string => WarehouseInfo) public warehouses;
    uint256 public warehouseCount; // Counter to keep track of the number of warehouses

    // Events to be emitted when a warehouse is created or its state is changed
    event WarehouseCreated(string warehouseId, string warehouseName, string warehouseType);
    event WarehouseStateChanged(string warehouseId, string state);

    /**
     * @dev Creates a new warehouse entry with the provided details.
     * @param info WarehouseInfo struct containing all the details for the warehouse.
     */
    function createWarehouse(WarehouseInfo memory info) public {
        // Store the warehouse information in the mapping
        warehouses[info.warehouseId] = WarehouseInfo({
            warehouseId: info.warehouseId,
            userWalletAddress: info.userWalletAddress,
            warehouseName: info.warehouseName,
            warehouseType: info.warehouseType,
            area: info.area,
            warehouseAddressLine1: info.warehouseAddressLine1,
            warehouseAddressLine2: info.warehouseAddressLine2,
            emirate: info.emirate,
            poBoxNumber: info.poBoxNumber,
            makaniNumber: info.makaniNumber,
            storageCommodities: info.storageCommodities,
            storageTypes: info.storageTypes,
            storageRestrictions: info.storageRestrictions,
            totalAvailableSpace: info.totalAvailableSpace,
            documents: info.documents,
            state: "UnderProcess", // Default state is UnderProcess
            images: info.images,
            properties: info.properties,
            iamUserId: info.iamUserId,
            description: info.description,
            coordinates: info.coordinates,
            price: info.price,
            country: info.country,
            city: info.city
        });

        warehouseCount++; // Increment the warehouse count

        // Emit an event to indicate a new warehouse has been created
        emit WarehouseCreated(info.warehouseId, info.warehouseName, info.warehouseType);
    }

    /**
     * @dev Changes the state of an existing warehouse.
     * @param _warehouseId ID of the warehouse to change the state.
     * @param _state New state to set for the warehouse.
     */
    function changeWarehouseState(string memory _warehouseId, string memory _state) public {
        // Update the state of the warehouse
        warehouses[_warehouseId].state = _state;

        // Emit an event to indicate the warehouse state has been changed
        emit WarehouseStateChanged(_warehouseId, _state);
    }

    /**
     * @dev Retrieves the information of a warehouse.
     * @param _warehouseId ID of the warehouse to retrieve.
     * @return WarehouseInfo struct containing all the details of the warehouse.
     */
    function getWarehouse(string memory _warehouseId) public view returns (WarehouseInfo memory) {
        return warehouses[_warehouseId];
    }
}
