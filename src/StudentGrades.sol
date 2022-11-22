// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./StorkContract.sol";

/// @title Demo Contract
/// @author Shankar "theblushirtdude" Subramanian
/// @notice Honestly idk what this is for
/// @dev Explain to a developer any extra details
contract StudentGrades is StorkContract {
    uint256 public passScore = 50;

    struct Student {
        string name;
        uint8 grade;
        uint8[] scores;
        bool canPromote;
        bool isEvaluated;
    }

    constructor(address payable _storkFundAddr) payable {
        storkSetup(_storkFundAddr);
        owner = msg.sender;
    }

    // function createPhalanx(string memory phalanxName, PhalanxType[] calldata phalanxType) external isOwner {
    function createPhalanx(string memory phalanxName) external isOwner {
        // [["string", "name", ""],["uint8", "grade", ""],["uint8[]", "scores", ""],
        // ["bool", "canPromote", ""],["bool", "isEvaluated", ""]]
        createPhalanxType(phalanxName); //, phalanxType);
    }

    function storeStudentData(
        string calldata _name,
        uint8 _grade,
        uint8[] calldata _scores,
        bool _canPromote,
        bool isEvaluated
    ) external {
        createStork(
            "student",
            abi.encode(
                Student({
                    name: _name,
                    grade: _grade,
                    scores: _scores,
                    canPromote: _canPromote,
                    isEvaluated: isEvaluated
                })
            )
        );
    }

    function checkStudentPassGrade(uint32[] memory _storkId) external {
        requestStorkById(
            "student",
            _storkId,
            "checkStudentPassGradeFallback(uint8,uint256,bytes)",
            "l1",
            address(this)
        );
    }

    function checkStudentPassGradeFallback(
        uint8 _storkId,
        uint256 _newReqId,
        bytes calldata _storkData,
        address _fromContract
    ) external checkReqId(_newReqId) approvedSenderContract(_fromContract) {
        uint256 scoreSum;

        Student memory student = abi.decode(_storkData, (Student));
        require(student.isEvaluated == false, "student has been evaluated");

        for (uint8 j = 0; j < student.scores.length; ++j) {
            scoreSum += student.scores[j];
        }

        if (scoreSum >= passScore) {
            student.canPromote = true;
        }

        student.isEvaluated = true;
        student.grade++;

        updateStorkById("student", _storkId, abi.encode(student));
    }

    function deleteGraduated(uint32[] memory _storkId) external {
        deleteStorkById("student", _storkId);
    }

    function decodeStudent(bytes calldata _data)
        public
        pure
        returns (Student memory)
    {
        return (abi.decode(_data, (Student)));
    }
}
