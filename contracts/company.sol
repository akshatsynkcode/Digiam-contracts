// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CompanyRegistration {
    enum CompanyStatus { UnderProcess, Approved, Rejected, ModificationRequired }

    struct Company {
        string companyId;
        string companyName;
        string companyEmail;
        string companyWebsite;
        string tradeLicenseNumber;
        string issueDate;
        string expiryDate;
        string companyMobileNumber;
        string companyLandlineNumber;
        string landlineExtension;
        string mobileExtension;
        string tradeLicense;
        string tradeLicenseIssuingEmirates;
        string tradeLicenseIssuingAuthority;
        string tradeLicenseCopy;
        string ejariDoc; // New field for Ejari document
        string emiratesId; // New field for Emirates ID
        CompanyStatus status;
    }

    mapping(string => Company) private companies;
    string[] private companyIds;

    event CompanyRegistered(string companyId, string companyName, string companyEmail);
    event CompanyUpdated(string companyId, string companyName, string companyEmail);
    event CompanyStatusChanged(string companyId, CompanyStatus newStatus);

    modifier companyExists(string memory _companyId) {
        require(bytes(companies[_companyId].companyId).length != 0, "Company not found");
        _;
    }

    function registerCompany(
        string memory _companyId,
        string memory _companyName,
        string memory _companyEmail,
        string memory _companyWebsite,
        string memory _tradeLicenseNumber,
        string memory _issueDate,
        string memory _expiryDate,
        string memory _companyMobileNumber,
        string memory _companyLandlineNumber,
        string memory _landlineExtension,
        string memory _mobileExtension,
        string memory _tradeLicense,
        string memory _tradeLicenseIssuingEmirates,
        string memory _tradeLicenseIssuingAuthority,
        string memory _tradeLicenseCopy,
        string memory _ejariDoc, // New parameter for Ejari document
        string memory _emiratesId // New parameter for Emirates ID
    ) public {
        require(bytes(companies[_companyId].companyId).length == 0, "Company already registered");

        companies[_companyId] = Company({
            companyId: _companyId,
            companyName: _companyName,
            companyEmail: _companyEmail,
            companyWebsite: _companyWebsite,
            tradeLicenseNumber: _tradeLicenseNumber,
            issueDate: _issueDate,
            expiryDate: _expiryDate,
            companyMobileNumber: _companyMobileNumber,
            companyLandlineNumber: _companyLandlineNumber,
            landlineExtension: _landlineExtension,
            mobileExtension: _mobileExtension,
            tradeLicense: _tradeLicense,
            tradeLicenseIssuingEmirates: _tradeLicenseIssuingEmirates,
            tradeLicenseIssuingAuthority: _tradeLicenseIssuingAuthority,
            tradeLicenseCopy: _tradeLicenseCopy,
            ejariDoc: _ejariDoc, // Store Ejari document URL
            emiratesId: _emiratesId, // Store Emirates ID URL
            status: CompanyStatus.UnderProcess
        });

        companyIds.push(_companyId);

        emit CompanyRegistered(_companyId, _companyName, _companyEmail);
    }

    function updateCompany(
        string memory _companyId,
        string memory _companyName,
        string memory _companyEmail,
        string memory _companyWebsite,
        string memory _tradeLicenseNumber,
        string memory _issueDate,
        string memory _expiryDate,
        string memory _companyMobileNumber,
        string memory _companyLandlineNumber,
        string memory _landlineExtension,
        string memory _mobileExtension,
        string memory _tradeLicense,
        string memory _tradeLicenseIssuingEmirates,
        string memory _tradeLicenseIssuingAuthority,
        string memory _tradeLicenseCopy,
        string memory _ejariDoc, // New parameter for Ejari document
        string memory _emiratesId // New parameter for Emirates ID
    ) public companyExists(_companyId) {
        Company storage company = companies[_companyId];
        company.companyName = _companyName;
        company.companyEmail = _companyEmail;
        company.companyWebsite = _companyWebsite;
        company.tradeLicenseNumber = _tradeLicenseNumber;
        company.issueDate = _issueDate;
        company.expiryDate = _expiryDate;
        company.companyMobileNumber = _companyMobileNumber;
        company.companyLandlineNumber = _companyLandlineNumber;
        company.landlineExtension = _landlineExtension;
        company.mobileExtension = _mobileExtension;
        company.tradeLicense = _tradeLicense;
        company.tradeLicenseIssuingEmirates = _tradeLicenseIssuingEmirates;
        company.tradeLicenseIssuingAuthority = _tradeLicenseIssuingAuthority;
        company.tradeLicenseCopy = _tradeLicenseCopy;
        company.ejariDoc = _ejariDoc; // Update Ejari document URL
        company.emiratesId = _emiratesId; // Update Emirates ID URL

        emit CompanyUpdated(_companyId, _companyName, _companyEmail);
    }

    function changeCompanyStatus(
        string memory _companyId,
        CompanyStatus _newStatus
    ) public companyExists(_companyId) {
        companies[_companyId].status = _newStatus;
        emit CompanyStatusChanged(_companyId, _newStatus);
    }

    function getCompany(string memory _companyId)
        public
        view
        companyExists(_companyId)
        returns (
            string memory companyName,
            string memory companyEmail,
            string memory companyWebsite,
            string memory tradeLicenseNumber,
            string memory issueDate,
            string memory expiryDate,
            string memory companyMobileNumber,
            string memory companyLandlineNumber,
            string memory landlineExtension,
            string memory mobileExtension,
            string memory tradeLicense,
            string memory tradeLicenseIssuingEmirates,
            string memory tradeLicenseIssuingAuthority,
            string memory tradeLicenseCopy,
            string memory ejariDoc, // Return Ejari document URL
            string memory emiratesId, // Return Emirates ID URL
            CompanyStatus status
        )
    {
        Company memory company = companies[_companyId];
        return (
            company.companyName,
            company.companyEmail,
            company.companyWebsite,
            company.tradeLicenseNumber,
            company.issueDate,
            company.expiryDate,
            company.companyMobileNumber,
            company.companyLandlineNumber,
            company.landlineExtension,
            company.mobileExtension,
            company.tradeLicense,
            company.tradeLicenseIssuingEmirates,
            company.tradeLicenseIssuingAuthority,
            company.tradeLicenseCopy,
            company.ejariDoc, // Return Ejari document URL
            company.emiratesId, // Return Emirates ID URL
            company.status
        );
    }

    function getAllCompanyIds() public view returns (string[] memory) {
        return companyIds;
    }
}
