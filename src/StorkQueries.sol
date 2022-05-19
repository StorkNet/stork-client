// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "./StorkTypes.sol";

/// @custom: Data Control Contract is called DCC

/// @title Stork Handler Contract
/// @author Shankar "theblushirtdude" Subramanian
/// @notice Used to connect a StorkContract to StorkNet
/// @dev
contract StorkQueries is StorkTypes {
    /// @notice Stores new data in the StorkNet
    /// @dev Increments the phalanx's storkLastId, makes a stork with the new id and data, then emits a event
    /// @param _phalanxName The StorkDataType
    /// @param _abiEncodeData The value of the data being stored
    function createStork(
        string memory _phalanxName,
        bytes memory _abiEncodeData
    ) internal {
        uint8 storkId = phalanxInfo[_phalanxName].phalanxLastId++ + 1;

        emit EventStorkCreate(
            _phalanxName,
            storkId,
            Stork({
                _id: storkId,
                _typeId: phalanxInfo[_phalanxName].phalanxTypeId,
                _data: _abiEncodeData
            })
        );
    }

    /// @notice Lets StorkNet know that this contract has a new Store request
    /// @param _phalanxName The address of the contract that created the new StorkDataType
    /// @param _storkId The data type name keccak256-ed because that's how events work
    /// @param _stork The data being stored
    event EventStorkCreate(
        string indexed _phalanxName,
        uint8 indexed _storkId,
        Stork _stork
    );

    //-------------------------------------------------------------------------------------

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
        emit EventStorkUpdateById(
            _phalanxName,
            _storkId,
            Stork({
                _id: phalanxInfo[_phalanxName].phalanxTypeId,
                _typeId: phalanxInfo[_phalanxName].phalanxTypeId,
                _data: _abiEncodeData
            })
        );
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
        emit EventStorkUpdateByParams(
            _phalanxName,
            _storkParam,
            Stork({
                _id: phalanxInfo[_phalanxName].phalanxTypeId,
                _typeId: phalanxInfo[_phalanxName].phalanxTypeId,
                _data: _abiEncodeData
            })
        );
    }

    /// @notice Lets StorkNet know that this contract has a new Store request
    /// @param _phalanxName The address of the contract that created the new StorkDataType
    /// @param _storkId The data type name keccak256-ed because that's how events work
    /// @param _stork The data being stored
    event EventStorkUpdateById(
        string indexed _phalanxName,
        uint32 indexed _storkId,
        Stork _stork
    );

    /// @notice Lets StorkNet know that this contract has a new Store request
    /// @param _phalanxName The address of the contract that created the new StorkDataType
    /// @param _storkParam The parameters being searched for in the update
    /// @param _stork The data being stored
    event EventStorkUpdateByParams(
        string indexed _phalanxName,
        StorkParameter[] indexed _storkParam,
        Stork _stork
    );

    //-------------------------------------------------------------------------------------

    /// @notice Stores the StorkDataType in the StorkNet
    /// @dev The event emitted tells StorkNet about the data being stored, it's type, and the contract associated
    /// @param _phalanxName The StorkDataType
    /// @param _storkId The index to delete
    function deleteStorkById(
        string memory _phalanxName,
        uint32[] memory _storkId
    ) internal {
        emit EventStorkDeleteById(_phalanxName, _storkId);
    }

    /// @notice Stores the StorkDataType in the StorkNet
    /// @dev The event emitted tells StorkNet about the data being stored, it's type, and the contract associated
    /// @param _phalanxName The StorkDataType
    /// @param _storkParam The index to delete
    function deleteStorkByParam(
        string memory _phalanxName,
        StorkParameter[] memory _storkParam
    ) internal {
        emit EventStorkDeleteByParams(_phalanxName, _storkParam);
    }

    /// @notice Lets StorkNet know that this contract has a new Store request
    /// @param _storkName The data type name keccak256-ed because that's how events work
    /// @param _storkId The index to delete
    event EventStorkDeleteById(
        string indexed _storkName,
        uint32[] indexed _storkId
    );

    /// @notice Lets StorkNet know that this contract has a new Store request
    /// @param _storkName The data type name keccak256-ed because that's how events work
    /// @param _storkParam The index to delete
    event EventStorkDeleteByParams(
        string indexed _storkName,
        StorkParameter[] indexed _storkParam
    );

    //-------------------------------------------------------------------------------------

    /// @notice Stores the StorkDataType in the StorkNet
    /// @notice Stores the StorkDataType in the StorkNet
    /// @dev The event emitted tells StorkNet about the data being stored, it's type, and the contract associated
    /// @param _phalanxName The StorkDataType
    /// @param _arrayOfIds The value of the data being stored
    /// @param _fallbackFunction The value of the data being stored
    function requestStorkById(
        string memory _phalanxName,
        uint32[] memory _arrayOfIds,
        bytes memory _fallbackFunction
    ) internal {
        emit EventStorkRequestId(_phalanxName, _arrayOfIds, _fallbackFunction);
    }

    /// @notice Stores the StorkDataType in the StorkNet
    /// @dev The event emitted tells StorkNet about the data being stored, it's type, and the contract associated
    /// @param _phalanxName The StorkDataType
    /// @param _storkRequestParameters The value of the data being stored
    /// @param _fallbackFunction The value of the data being stored
    function requestStorkByParams(
        string memory _phalanxName,
        StorkParameter[] memory _storkRequestParameters,
        bytes memory _fallbackFunction
    ) internal {
        emit EventStorkRequestByParams(
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
        bytes memory _fallbackFunction
    ) internal {
        emit EventStorkRequestByRange(
            _phalanxName,
            _storkIdRange,
            _fallbackFunction
        );
    }

    /// @notice Lets StorkNet know that this contract has a new Store request
    /// @param _phalanxName The address of the contract that created the new StorkDataType
    /// @param _arrayOfIds The data type name keccak256-ed because that's how events work
    /// @param _fallbackFunction The data being stored
    event EventStorkRequestId(
        string indexed _phalanxName,
        uint32[] indexed _arrayOfIds,
        bytes indexed _fallbackFunction
    );

    /// @notice Lets StorkNet know that this contract has a new Store request
    /// @param _phalanxName The address of the contract that created the new StorkDataType
    /// @param _storkRequestParameters The data type name keccak256-ed because that's how events work
    /// @param _fallbackFunction The data being stored
    event EventStorkRequestByParams(
        string indexed _phalanxName,
        StorkParameter[] indexed _storkRequestParameters,
        bytes indexed _fallbackFunction
    );

    /// @notice Lets StorkNet know that this contract has a new Store request
    /// @param _phalanxName The address of the contract that created the new StorkDataType
    /// @param _storkIdRange The data type name keccak256-ed because that's how events work
    /// @param _fallbackFunction The data being stored
    event EventStorkRequestByRange(
        string indexed _phalanxName,
        uint32[] indexed _storkIdRange,
        bytes indexed _fallbackFunction
    );

    //-------------------------------------------------------------------------------------
}
