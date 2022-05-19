// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "./StorkContract.sol";

/// @title Demo Contract
/// @author Shankar "theblushirtdude" Subramanian
/// @notice Honestly idk what this is for
/// @dev Explain to a developer any extra details
contract DemoContract is StorkContract {
    uint256 public passScore = 50;

    struct Student {
        string name;
        uint8 grade;
        uint8[6] scores;
        bool canPromote;
        bool isEvaluated;
    }

    constructor(address payable _dataControlAddr) payable {
        storkSetup(_dataControlAddr);
    }

    function createStudentPhalanx() external {
        PhalanxType[] memory newPhalanxType;

        newPhalanxType[0] = PhalanxType({
            varType: "string",
            varName: "name",
            varIndex: ""
        });
        newPhalanxType[1] = PhalanxType({
            varType: "uint8",
            varName: "grade",
            varIndex: ""
        });
        newPhalanxType[2] = PhalanxType({
            varType: "uint8[]",
            varName: "scores",
            varIndex: ""
        });
        newPhalanxType[3] = PhalanxType({
            varType: "bool",
            varName: "canPromote",
            varIndex: ""
        });
        newPhalanxType[3] = PhalanxType({
            varType: "bool",
            varName: "isEvaluated",
            varIndex: ""
        });
        createPhalanxType("student", newPhalanxType);
    }

    function storeStudentData(
        string calldata _name,
        uint8 _grade,
        uint8[6] calldata _scores,
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
        requestStorkById("student", _storkId, "checkStudentPassGradeFallback");
    }

    function checkStudentPassGradeFallback(
        uint8[] calldata _storkId,
        bytes calldata _storkData
    ) external {
        Student[] memory students = abi.decode(_storkData, (Student[]));
        // or Student memory student = decodeStudent(_storkData); costs slightly more gas ?
        uint8 scoreSum;

        uint256 len = students.length;
        for (uint8 i = 0; i < len; ++i) {
            if (students[i].isEvaluated == true) {
                continue;
            }

            for (uint8 j = 0; j < 6; j++) {
                scoreSum += students[i].scores[i];
            }

            if (scoreSum >= passScore) {
                students[i].canPromote = true;
            }

            students[i].isEvaluated = true;
            students[i].grade++;

            updateStorkById("student", _storkId[i], abi.encode(students[i]));
        }
    }

    function decodeStudent(bytes calldata _data)
        public
        pure
        returns (Student memory)
    {
        return (abi.decode(_data, (Student)));
    }
}
