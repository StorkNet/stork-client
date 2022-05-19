// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "./StorkContract.sol";

/// @title Demo Contract
/// @author Shankar "theblushirtdude" Subramanian
/// @notice Honestly idk what this is for
/// @dev Explain to a developer any extra details
contract DemoContract is StorkContract {
    struct Student {
        string name;
        uint256 age;
        bool isMale;
    }

    constructor(address payable _dataControlAddr) payable {
        setDataControlConractAddr(_dataControlAddr);
        // also need multi sig addr
        (bool success, ) = dataControlContract.call{value: msg.value}(
            abi.encodeWithSignature("addStorkContract()")
        );
        require(success, "Failed to add stork contract");
    }

    function storeStudentData(
        string calldata _name,
        uint256 _age,
        bool _isMale
    ) external {
        createStork(
            "student",
            abi.encode(Student({name: _name, age: _age, isMale: _isMale}))
        );
    }

    function increaseAgeByOne(uint32[] memory _storkId) external {
        requestStorkById("student", _storkId, "increaseAgeByOneFallback");
    }

    function increaseAgeByOneFallback(
        uint32 _storkId,
        bytes calldata _storkData
    ) external pure {
        Student memory student = abi.decode(_storkData, (Student));

        // or Student memory student = decodeStudent(_storkData); costs slightly more gas

        student.age++;

        ("student", _storkId, abi.encode(student));
    }

    function decodeStudent(bytes calldata _data)
        public
        pure
        returns (Student memory)
    {
        return (abi.decode(_data, (Student)));
    }
}
