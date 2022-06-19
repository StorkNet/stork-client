// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./StorkTypes.sol";

contract StorkQuery is StorkTypes {
    function createStork(
        string memory _phalanxName,
        uint8 _storkId,
        bytes memory _abiEncodeData
    ) external {}

    function updateStorkById(
        string memory _phalanxName,
        uint32 _storkId,
        bytes memory _abiEncodeData
    ) external {}

    function updateStorkByParam(
        string memory _phalanxName,
        StorkParameter[] memory _storkParam,
        bytes memory _abiEncodeData
    ) external {}

    function deleteStorkById(
        string memory _phalanxName,
        uint32[] memory _storkId
    ) external {}

    function deleteStorkByParam(
        string memory _phalanxName,
        StorkParameter[] memory _storkParam
    ) external {}

    function requestStorkById(
        string memory _phalanxName,
        uint32[] memory _storkId,
        string memory _fallbackFunction
    ) external {}

    function requestStorkByParam(
        string memory _phalanxName,
        StorkParameter[] memory _storkParam,
        string memory _fallbackFunction
    ) external {}

    function requestStorkByRange(
        string memory _phalanxName,
        uint32[] memory _storkIdRange,
        string memory _fallbackFunction
    ) external {}
}

/// @custom: Data Control Contract is called DCC

/// @title Stork Handler Contract
/// @author Shankar "theblushirtdude" Subramanian
/// @notice Used to connect a StorkContract to StorkNet
/// @dev
contract StorkQueries is StorkTypes {
    StorkQuery public storkQuery;

    /// @notice Stores new data in the StorkNet
    /// @dev Increments the phalanx's storkLastId, makes a stork with the new id and data, then emits a event
    /// @param _phalanxName The StorkDataType
    /// @param _abiEncodeData The value of the data being stored
    function createStork(
        string memory _phalanxName,
        bytes memory _abiEncodeData
    ) internal {
        uint8 storkId = phalanxInfo[_phalanxName].phalanxLastId++ + 1;
        storkQuery.createStork(_phalanxName, storkId, _abiEncodeData);
    }

    /// @notice Stores the StorkDataType in the StorkNet
    /// @dev The event emitted tells StorkNet about the data being stored, it's type, and the contract associated
    /// @param _phalanxName The StorkDataType
    /// @param _storkId The value of the data being stored
    /// @param _abiEncodeData The value of the data being stored
    function updateStorkById(
        string memory _phalanxName,
        uint32 _storkId,
        bytes memory _abiEncodeData
    ) internal {
        storkQuery.updateStorkById(_phalanxName, _storkId, _abiEncodeData);
    }

    /// @notice Stores the StorkDataType in the StorkNet
    /// @dev The event emitted tells StorkNet about the data being stored, it's type, and the contract associated
    /// @param _phalanxName The StorkDataType
    /// @param _storkParam The parameters of the data being stored
    /// @param _abiEncodeData The value of the data being stored
    function updateStorkByParam(
        string memory _phalanxName,
        StorkParameter[] memory _storkParam,
        bytes memory _abiEncodeData
    ) internal {
        storkQuery.updateStorkByParam(
            _phalanxName,
            _storkParam,
            _abiEncodeData
        );
    }

    /// @notice Stores the StorkDataType in the StorkNet
    /// @dev The event emitted tells StorkNet about the data being stored, it's type, and the contract associated
    /// @param _phalanxName The StorkDataType
    /// @param _storkId The index to delete
    function deleteStorkById(
        string memory _phalanxName,
        uint32[] memory _storkId
    ) internal {
        storkQuery.deleteStorkById(_phalanxName, _storkId);
    }

    /// @notice Stores the StorkDataType in the StorkNet
    /// @dev The event emitted tells StorkNet about the data being stored, it's type, and the contract associated
    /// @param _phalanxName The StorkDataType
    /// @param _storkParam The index to delete
    function deleteStorkByParam(
        string memory _phalanxName,
        StorkParameter[] memory _storkParam
    ) internal {
        storkQuery.deleteStorkByParam(_phalanxName, _storkParam);
    }

    /// @notice Stores the StorkDataType in the StorkNet
    /// @notice Stores the StorkDataType in the StorkNet
    /// @dev The event emitted tells StorkNet about the data being stored, it's type, and the contract associated
    /// @param _phalanxName The StorkDataType
    /// @param _arrayOfIds The value of the data being stored
    /// @param _fallbackFunction The value of the data being stored
    function requestStorkById(
        string memory _phalanxName,
        uint32[] memory _arrayOfIds,
        string memory _fallbackFunction
    ) internal {
        storkQuery.requestStorkById(
            _phalanxName,
            _arrayOfIds,
            _fallbackFunction
        );
    }

    /// @notice Stores the StorkDataType in the StorkNet
    /// @dev The event emitted tells StorkNet about the data being stored, it's type, and the contract associated
    /// @param _phalanxName The StorkDataType
    /// @param _storkRequestParameters The value of the data being stored
    /// @param _fallbackFunction The value of the data being stored
    function requestStorkByParams(
        string memory _phalanxName,
        StorkParameter[] memory _storkRequestParameters,
        string memory _fallbackFunction
    ) internal {
        storkQuery.requestStorkByParam(
            _phalanxName,
            _storkRequestParameters,
            _fallbackFunction
        );
    }

    /// @dev The event emitted tells StorkNet about the data being stored, it's type, and the contract associated
    /// @param _phalanxName The StorkDataType
    /// @param _storkIdRange The value of the data being stored
    /// @param _fallbackFunction The value of the data being stored
    function requestStorkByRange(
        string memory _phalanxName,
        uint32[] memory _storkIdRange,
        string memory _fallbackFunction
    ) internal {
        storkQuery.requestStorkByRange(
            _phalanxName,
            _storkIdRange,
            _fallbackFunction
        );
    }
}
