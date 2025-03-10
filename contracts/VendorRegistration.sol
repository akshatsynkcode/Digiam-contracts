// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VendorRegistration {
    struct Vendor {
        string vendorId;  // Unique vendor ID
        string vendorName;
        string vendorEmail;
        string website;
        string tradeLicenseNumber;
        string issueDate;
        string expiryDate;
        string mobileNumber;
        string landlineNumber;
        string tradeLicense;
        string tradeLicenseIssuingEmirates;
        string tradeLicenseIssuingAuthority;
        string tradeLicenseCopy;
        string ownershipTitleOrLeaseDocument;
        string emiratesIdForRepresentative;
    }

    mapping(string => Vendor) public vendors;  // Mapping using vendorId as the key

    // Function to register a new vendor
    function registerVendor(
        string memory _vendorId,
        string memory _vendorName,
        string memory _vendorEmail,
        string memory _website,
        string memory _tradeLicenseNumber,
        string memory _issueDate,
        string memory _expiryDate,
        string memory _mobileNumber,
        string memory _landlineNumber,
        string memory _tradeLicense,
        string memory _tradeLicenseIssuingEmirates,
        string memory _tradeLicenseIssuingAuthority,
        string memory _tradeLicenseCopy,
        string memory _ownershipTitleOrLeaseDocument,
        string memory _emiratesIdForRepresentative
    ) public {
        // Ensure the vendor does not already exist
        require(bytes(vendors[_vendorId].vendorId).length == 0, "Vendor already registered.");

        // Create a new Vendor
        vendors[_vendorId] = Vendor({
            vendorId: _vendorId,
            vendorName: _vendorName,
            vendorEmail: _vendorEmail,
            website: _website,
            tradeLicenseNumber: _tradeLicenseNumber,
            issueDate: _issueDate,
            expiryDate: _expiryDate,
            mobileNumber: _mobileNumber,
            landlineNumber: _landlineNumber,
            tradeLicense: _tradeLicense,
            tradeLicenseIssuingEmirates: _tradeLicenseIssuingEmirates,
            tradeLicenseIssuingAuthority: _tradeLicenseIssuingAuthority,
            tradeLicenseCopy: _tradeLicenseCopy,
            ownershipTitleOrLeaseDocument: _ownershipTitleOrLeaseDocument,
            emiratesIdForRepresentative: _emiratesIdForRepresentative
        });
    }

    // Function to update vendor details
    function updateVendorDetails(
        string memory _vendorId,
        string memory _newWebsite,
        string memory _newVendorEmail,
        string memory _newVendorName,
        string memory _newMobileNumber,
        string memory _newLandlineNumber,
        string memory _newTradeLicense,
        string memory _newIssueDate,
        string memory _newExpiryDate,
        string memory _newTradeLicenseIssuingEmirates,
        string memory _newTradeLicenseIssuingAuthority,
        string memory _newTradeLicenseCopy,
        string memory _newOwnershipTitleOrLeaseDocument,
        string memory _newEmiratesIdForRepresentative
    ) public {
        // Check if the vendor exists
        require(bytes(vendors[_vendorId].vendorId).length > 0, "Vendor does not exist.");

        // Update the vendor details
        Vendor storage vendor = vendors[_vendorId];
        vendor.website = _newWebsite;
        vendor.vendorEmail = _newVendorEmail;
        vendor.vendorName = _newVendorName;
        vendor.mobileNumber = _newMobileNumber;
        vendor.landlineNumber = _newLandlineNumber;
        vendor.tradeLicense = _newTradeLicense;
        vendor.issueDate = _newIssueDate;
        vendor.expiryDate = _newExpiryDate;
        vendor.tradeLicenseIssuingEmirates = _newTradeLicenseIssuingEmirates;
        vendor.tradeLicenseIssuingAuthority = _newTradeLicenseIssuingAuthority;
        vendor.tradeLicenseCopy = _newTradeLicenseCopy;
        vendor.ownershipTitleOrLeaseDocument = _newOwnershipTitleOrLeaseDocument;
        vendor.emiratesIdForRepresentative = _newEmiratesIdForRepresentative;
    }

    // Function to get vendor details by vendor ID
    function getVendor(string memory _vendorId) public view returns (Vendor memory) {
        return vendors[_vendorId];
    }
}
