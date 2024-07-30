// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract UserInfo {
    struct User {
        string fullName;
        string email;
        bool isRegistered;
        bool isUser;
        bool isEmployee;
        bool isAdmin;
    }
    mapping(uint256 => User) public users;
    mapping(string => uint256) private emailToRefId;

    // Event to emit when a user is added or updated
    event UserAdded(uint256 indexed referenceId, string fullName, string email, bool isUser, bool isEmployee, bool isAdmin);
    event UserUpdated(uint256 indexed referenceId, string fullName, string email, bool isUser, bool isEmployee, bool isAdmin);
    event UserRemoved(uint256 indexed referenceId, string email);

    // Function to add or update a user
    function saveUser(uint256 _referenceId, string memory _fullName, string memory _email, bool _isUser, bool _isEmployee, bool _isAdmin) public {
        require(_referenceId != 0, "Reference ID cannot be zero");
        require(bytes(_fullName).length > 0, "Full name cannot be empty");
        require(bytes(_email).length > 0, "Email cannot be empty");
        require(validateEmailFormat(_email), "Invalid email format");
        require(validateRoles(_isUser, _isEmployee, _isAdmin), "Only one role can be true");
        require(isUniqueEmail(_referenceId, _email), "Email must be unique");

        User storage user = users[_referenceId];
        if (user.isRegistered) {
            // Update existing user
            emailToRefId[user.email] = 0; // Clear old email association
            user.fullName = _fullName;
            user.email = _email;
            user.isUser = _isUser;
            user.isEmployee = _isEmployee;
            user.isAdmin = _isAdmin;
            emailToRefId[_email] = _referenceId; // Set new email association
            emit UserUpdated(_referenceId, _fullName, _email, _isUser, _isEmployee, _isAdmin);
        } else {
            // Add new user
            users[_referenceId] = User(_fullName, _email, true, _isUser, _isEmployee, _isAdmin);
            emailToRefId[_email] = _referenceId;
            emit UserAdded(_referenceId, _fullName, _email, _isUser, _isEmployee, _isAdmin);
        }
    }

    // Function to validate unique email
    function isUniqueEmail(uint256 _referenceId, string memory _email) internal view returns (bool) {
        uint256 existingRefId = emailToRefId[_email];
        return existingRefId == 0 || existingRefId == _referenceId;
    }

    // Simple email format validation
    function validateEmailFormat(string memory _email) internal pure returns (bool) {
        bytes memory email = bytes(_email);
        bool seenAtSymbol = false;
        for(uint i = 0; i < email.length; i++) {
            if(email[i] == "@") {
                seenAtSymbol = true;
            }
            if(seenAtSymbol && email[i] == ".") {
                return true;
            }
        }
        return false;
    }

    // Function to validate roles
    function validateRoles(bool _isUser, bool _isEmployee, bool _isAdmin) internal pure returns (bool) {
        uint count = 0;
        if (_isUser) count++;
        if (_isEmployee) count++;
        if (_isAdmin) count++;
        return count == 1;
    }

    // Function to get user details by reference ID
    function getUser(uint256 _referenceId) public view returns (string memory, string memory, bool, bool, bool) {
        require(users[_referenceId].isRegistered, "User does not exist");
        User memory user = users[_referenceId];
        return (user.fullName, user.email, user.isUser, user.isEmployee, user.isAdmin);
    }

    // Function to remove a user by reference ID
    function removeUser(uint256 _referenceId) public {
        require(users[_referenceId].isRegistered, "User does not exist");
        string memory email = users[_referenceId].email;
        delete emailToRefId[email]; // Remove email association
        delete users[_referenceId]; // Remove user
        emit UserRemoved(_referenceId, email);
    }
}
