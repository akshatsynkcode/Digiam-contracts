// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EmployeeRegistry {

    struct Service {  // This will still represent a service (employee in terms of functionality)
        string id;
        string name;
        string emailId;
        string serviceNames;
    }

    mapping(string => Service) public employees;  // Updated to represent employees
    uint256 public employeeCount;  // Updated to track employee count

    event EmployeeAdded(string indexed id, string name, string emailId, string serviceNames);  // Event for adding employee
    event EmployeeUpdated(string indexed id, string name, string emailId, string serviceNames);  // Event for updating employee
    event EmployeeDeleted(string indexed id);  // Event for deleting employee

    constructor() {
        employeeCount = 0;
    }

    // Add a new employee to the registry
    function addEmployee(
        string memory _id,
        string memory _name,
        string memory _emailId,
        string memory _serviceNames
    ) public {
        employeeCount++;
        employees[_id] = Service(_id, _name, _emailId, _serviceNames);
        emit EmployeeAdded(_id, _name, _emailId, _serviceNames);
    }

    // Update an existing employee's information
    function updateEmployee(
        string memory _id,
        string memory _name,
        string memory _emailId,
        string memory _serviceNames
    ) public {
        require(bytes(employees[_id].id).length != 0, "Employee does not exist.");
        Service storage employee = employees[_id];
        employee.name = _name;
        employee.emailId = _emailId;
        employee.serviceNames = _serviceNames;
        emit EmployeeUpdated(_id, _name, _emailId, _serviceNames);
    }

    // Delete an employee from the registry
    function deleteEmployee(string memory _id) public {
        require(bytes(employees[_id].id).length != 0, "Employee does not exist.");
        delete employees[_id];
        emit EmployeeDeleted(_id);
    }

    // Get the details of a specific employee by ID
    function getEmployee(string memory _id) public view returns (
        string memory id,
        string memory name,
        string memory emailId,
        string memory serviceNames
    ) {
        require(bytes(employees[_id].id).length != 0, "Employee does not exist.");
        Service memory employee = employees[_id];
        return (employee.id, employee.name, employee.emailId, employee.serviceNames);
    }

}
