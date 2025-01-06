// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract UserInfo {
    struct User {
        string fullName;
        string email;
        string isRegistered; // "true" or "false"
        string isUser;       // "true" or "false"
        string isEmployee;   // "true" or "false"
        string isAdmin;      // "true" or "false"
    }

    mapping(uint256 => User) public users;

    // Events for user actions
    event UserChanged(uint256 indexed referenceId, string fullName, string email, string action);

    // Function to add or update a user
    function saveUser(uint256 _referenceId, string memory _fullName, string memory _email, string memory _isUser, string memory _isEmployee, string memory _isAdmin) public {
        require(_referenceId != 0, "Reference ID cannot be zero");
        require(bytes(_fullName).length > 0, "Full name cannot be empty");
        require(bytes(_email).length > 0, "Email cannot be empty");

        User storage user = users[_referenceId];
        if (compareStrings(user.isRegistered, "true")) {
            // Update existing user
            user.fullName = _fullName;
            user.email = _email;
            user.isUser = _isUser;
            user.isEmployee = _isEmployee;
            user.isAdmin = _isAdmin;
            emit UserChanged(_referenceId, _fullName, _email, "updated");
        } else {
            // Add new user
            users[_referenceId] = User(_fullName, _email, "true", _isUser, _isEmployee, _isAdmin);
            emit UserChanged(_referenceId, _fullName, _email, "added");
        }
    }

    // Function to remove a user by reference ID
    function removeUser(uint256 _referenceId) public {
        require(compareStrings(users[_referenceId].isRegistered, "true"), "User does not exist");
        delete users[_referenceId];
        emit UserChanged(_referenceId, users[_referenceId].fullName, users[_referenceId].email, "removed");
    }

    // Function to get user details by reference ID
    function getUser(uint256 _referenceId) public view returns (
        string memory fullName,
        string memory email,
        string memory isRegistered,
        string memory isUser,
        string memory isEmployee,
        string memory isAdmin
    ) {
        require(compareStrings(users[_referenceId].isRegistered, "true"), "User does not exist");
        User memory user = users[_referenceId];
        return (
            user.fullName,
            user.email,
            user.isRegistered,
            user.isUser,
            user.isEmployee,
            user.isAdmin
        );
    }

    // Helper function to compare strings
    function compareStrings(string memory a, string memory b) internal pure returns (bool) {
        return keccak256(abi.encodePacked(a)) == keccak256(abi.encodePacked(b));
    }
}
