// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract UAET {
    string public constant name = "United Arab Emirates Token";
    string public constant symbol = "UAET";
    uint8 public constant decimals = 18;
    uint256 public constant totalSupply = 1_000_000_000_000 * 10**18; // 1 trillion tokens

    mapping(address => uint256) public balanceOf;

    address public owner;

    event Transfer(address indexed from, address indexed to, uint256 value);

    constructor() {
        owner = msg.sender;
        balanceOf[address(this)] = totalSupply; // Assign total supply to the contract itself
        emit Transfer(address(0), address(this), totalSupply);
    }

    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(_to != address(0), "Transfer to the zero address is not allowed");
        require(balanceOf[msg.sender] >= _value, "Insufficient balance");

        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;

        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    function mint(address _to, uint256 _value) public returns (bool success) {
        require(_to != address(0), "Mint to the zero address is not allowed");
        require(balanceOf[address(this)] >= _value, "Insufficient balance in contract");

        balanceOf[address(this)] -= _value;
        balanceOf[_to] += _value;

        emit Transfer(address(this), _to, _value);
        return true;
    }
}
