// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract StudentRecord {
    struct Record { string name; string rollNumber; string course; bool exists; }
    mapping(address => Record) private records;

    function addRecord(string calldata name, string calldata rollNumber, string calldata course) external {
        require(!records[msg.sender].exists, "Record already exists");
        require(bytes(name).length > 0 && bytes(rollNumber).length > 0, "Name and roll number required");
        records[msg.sender] = Record(name, rollNumber, course, true);
    }
    function updateRecord(string calldata name, string calldata rollNumber, string calldata course) external {
        require(records[msg.sender].exists, "Create record first");
        require(bytes(name).length > 0 && bytes(rollNumber).length > 0, "Name and roll number required");
        records[msg.sender] = Record(name, rollNumber, course, true);
    }
    function getRecord() external view returns (string memory name, string memory rollNumber, string memory course) {
        require(records[msg.sender].exists, "No record found");
        Record storage r = records[msg.sender];
        return (r.name, r.rollNumber, r.course);
    }
    function recordExists() external view returns (bool) { return records[msg.sender].exists; }
}
