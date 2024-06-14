// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract UserInfo {
    struct User {
        string fullName;
        string email;
        bool isRegistered;
        address walletAddress;
    }
    mapping(uint256 => User) public users;
    mapping(address => bool) private usedAddresses;
    // Event to emit when a user is added
    event UserAdded(uint256 indexed referenceId, string fullName, string email, address walletAddress);
    event UserUpdated(uint256 indexed referenceId, string fullName, string email);
    // Function to add or update a user
    function saveUser(uint256 _referenceId, string memory _fullName, string memory _email) public {
        require(bytes(_fullName).length > 0, "Full name cannot be empty");
        require(bytes(_email).length > 0, "Email cannot be empty");
        
        User storage user = users[_referenceId];
        if (user.isRegistered) {
            // Update existing user
            user.fullName = _fullName;
            user.email = _email;
            emit UserUpdated(_referenceId, _fullName, _email);
        } else {
            // Add new user
            address walletAddress = generateWalletAddress(_referenceId);
            users[_referenceId] = User(_fullName, _email, true, walletAddress);
            emit UserAdded(_referenceId, _fullName, _email, walletAddress);
        }
    }
    // Function to get user details by reference ID
    function getUser(uint256 _referenceId) public view returns (string memory, string memory, address) {
        require(users[_referenceId].isRegistered, "User does not exist");
        User memory user = users[_referenceId];
        return (user.fullName, user.email, user.walletAddress);
    }
    // Internal function to generate a pseudo-wallet address
    function generateWalletAddress(uint256 _referenceId) internal returns (address) {
        address newAddress = address(uint160(uint256(keccak256(abi.encodePacked(block.timestamp, block.difficulty, _referenceId)))));
        require(!usedAddresses[newAddress], "Address already in use");
        usedAddresses[newAddress] = true;
        return newAddress;
    }
}