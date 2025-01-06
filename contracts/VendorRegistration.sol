// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VendorRegistration {
    struct Vendor {
        string tradeLicenseCopy;
        string vendorId;
        string website;
        string email;
        string name;
    }

    mapping(string => Vendor) public vendors;

    // Function to register a new vendor
    function registerVendor(
        string memory _tradeLicenseCopy,
        string memory _vendorId,
        string memory _website,
        string memory _email,
        string memory _name
    ) public {
        // Ensure the vendor does not already exist
        require(bytes(vendors[_vendorId].vendorId).length == 0, "Vendor already registered.");

        // Create new Vendor
        vendors[_vendorId] = Vendor({
            tradeLicenseCopy: _tradeLicenseCopy,
            vendorId: _vendorId,
            website: _website,
            email: _email,
            name: _name
        });
    }

    // Function to update vendor details
    function updateVendorDetails(
        string memory _vendorId,
        string memory _newWebsite,
        string memory _newEmail,
        string memory _newName
    ) public {
        // Check if the vendor exists
        require(bytes(vendors[_vendorId].vendorId).length > 0, "Vendor does not exist.");

        // Update the vendor details
        Vendor storage vendor = vendors[_vendorId];
        vendor.website = _newWebsite;
        vendor.email = _newEmail;
        vendor.name = _newName;
    }

    // Function to get vendor details by vendor ID
    function getVendor(string memory _vendorId) public view returns (Vendor memory) {
        return vendors[_vendorId];
    }
}
