// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EmployeeContract {
    // Mapping to store employee details
    mapping(string => Employee) public employees;

    // Structure for Employee data
    struct Employee {
        string id;             // Employee unique ID
        string name;           // Employee Name
        string email_id;       // Employee Email ID
        string warehouse_names; // Warehouse names (can be a comma-separated string or similar)
    }

    // Event to log employee data addition
    event EmployeeAdded(string employeeId, string name, string email_id, string warehouse_names);
    
    // Add or update employee details
    function addOrUpdateEmployee(
        string memory _id,
        string memory _name,
        string memory _email_id,
        string memory _warehouse_names
    ) public {
        // Update or add the employee details to the mapping
        employees[_id] = Employee(_id, _name, _email_id, _warehouse_names);
        
        // Emit an event after adding/updating
        emit EmployeeAdded(_id, _name, _email_id, _warehouse_names);
    }

    // Retrieve employee details by ID
    function getEmployee(string memory _id) public view returns (Employee memory) {
        return employees[_id];
    }

    // Retrieve warehouse names for a specific employee
    function getWarehouseNames(string memory _id) public view returns (string memory) {
        return employees[_id].warehouse_names;
    }
}
