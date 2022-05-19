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
    /// @param _storkData The value of the data being stored
    function createStork(string memory _phalanxName, bytes memory _storkData)
        internal
    {
        uint8 storkId = phalanxInfo[_phalanxName].storkLastId++ + 1;

        emit StorkCreate(
            _phalanxName,
            storkId,
            Stork({
                _id: storkId,
                _typeId: phalanxInfo[_phalanxName].storkTypeId,
                _data: _storkData
            })
        );
    }

    /// @notice Lets StorkNet know that this contract has a new Store request
    /// @param _phalanxName The address of the contract that created the new StorkDataType
    /// @param _storkId The data type name keccak256-ed because that's how events work
    /// @param _stork The data being stored
    event StorkCreate(
        string indexed _phalanxName,
        uint8 indexed _storkId,
        Stork _stork
    );

    //-------------------------------------------------------------------------------------

    /// @notice Stores the StorkDataType in the StorkNet
    /// @dev The event emitted tells StorkNet about the data being stored, it's type, and the contract associated
    /// @param _phalanxName The StorkDataType
    /// @param _storkId The value of the data being stored
    /// @param _storkData The value of the data being stored
    function updateStorkById(
        string memory _phalanxName,
        uint8 _storkId,
        bytes memory _storkData
    ) internal {
        emit StorkUpdateById(
            _phalanxName,
            _storkId,
            Stork({
                _id: _storkId,
                _typeId: phalanxInfo[_phalanxName].storkTypeId,
                _data: _storkData
            })
        );
    }

    /// @notice Stores the StorkDataType in the StorkNet
    /// @dev The event emitted tells StorkNet about the data being stored, it's type, and the contract associated
    /// @param _phalanxName The StorkDataType
    /// @param _storkParam The parameters of the data being stored
    /// @param _storkData The value of the data being stored
    function updateStorkByParam(
        string memory _phalanxName,
        StorkRequestParameters[] memory _storkParam,
        bytes memory _storkData
    ) internal {
        emit StorkUpdateByParams(
            _phalanxName,
            _storkParam,
            Stork({
                _id: phalanxInfo[_phalanxName].storkTypeId,
                _typeId: phalanxInfo[_phalanxName].storkTypeId,
                _data: _storkData
            })
        );
    }

    /// @notice Lets StorkNet know that this contract has a new Store request
    /// @param _phalanxName The address of the contract that created the new StorkDataType
    /// @param _storkId The data type name keccak256-ed because that's how events work
    /// @param _stork The data being stored
    event StorkUpdateById(
        string indexed _phalanxName,
        uint32 indexed _storkId,
        Stork _stork
    );

    /// @notice Lets StorkNet know that this contract has a new Store request
    /// @param _phalanxName The address of the contract that created the new StorkDataType
    /// @param _storkParam The parameters being searched for in the update
    /// @param _stork The data being stored
    event StorkUpdateByParams(
        string indexed _phalanxName,
        StorkRequestParameters[] indexed _storkParam,
        Stork _stork
    );

    //-------------------------------------------------------------------------------------

    /// @notice Stores the StorkDataType in the StorkNet
    /// @dev The event emitted tells StorkNet about the data being stored, it's type, and the contract associated
    /// @param _phalanxName The StorkDataType
    /// @param _storkId The index to delete
    function deleteStorkById(string calldata _phalanxName, uint32 _storkId)
        internal
    {
        emit StorkDeleteById(_phalanxName, _storkId);
    }

    /// @notice Stores the StorkDataType in the StorkNet
    /// @dev The event emitted tells StorkNet about the data being stored, it's type, and the contract associated
    /// @param _phalanxName The StorkDataType
    /// @param _storkParam The index to delete
    function deleteStorkByParam(
        string calldata _phalanxName,
        StorkRequestParameters[] memory _storkParam
    ) internal {
        emit StorkDeleteByParams(_phalanxName, _storkParam);
    }

    /// @notice Lets StorkNet know that this contract has a new Store request
    /// @param _storkName The data type name keccak256-ed because that's how events work
    /// @param _storkId The index to delete
    event StorkDeleteById(string indexed _storkName, uint32 indexed _storkId);

    /// @notice Lets StorkNet know that this contract has a new Store request
    /// @param _storkName The data type name keccak256-ed because that's how events work
    /// @param _storkParam The index to delete
    event StorkDeleteByParams(
        string indexed _storkName,
        StorkRequestParameters[] indexed _storkParam
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
        emit StorkRequestId(_phalanxName, _arrayOfIds, _fallbackFunction);
    }

    /// @notice Stores the StorkDataType in the StorkNet
    /// @dev The event emitted tells StorkNet about the data being stored, it's type, and the contract associated
    /// @param _phalanxName The StorkDataType
    /// @param _storkRequestParameters The value of the data being stored
    /// @param _fallbackFunction The value of the data being stored
    function requestStorkByParams(
        string memory _phalanxName,
        StorkRequestParameters[] memory _storkRequestParameters,
        bytes memory _fallbackFunction
    ) internal {
        emit StorkRequestByParams(
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
        emit StorkRequestByRange(
            _phalanxName,
            _storkIdRange,
            _fallbackFunction
        );
    }

    /// @notice Lets StorkNet know that this contract has a new Store request
    /// @param _phalanxName The address of the contract that created the new StorkDataType
    /// @param _arrayOfIds The data type name keccak256-ed because that's how events work
    /// @param _fallbackFunction The data being stored
    event StorkRequestId(
        string indexed _phalanxName,
        uint32[] indexed _arrayOfIds,
        bytes indexed _fallbackFunction
    );

    /// @notice Lets StorkNet know that this contract has a new Store request
    /// @param _phalanxName The address of the contract that created the new StorkDataType
    /// @param _storkRequestParameters The data type name keccak256-ed because that's how events work
    /// @param _fallbackFunction The data being stored
    event StorkRequestByParams(
        string indexed _phalanxName,
        StorkRequestParameters[] indexed _storkRequestParameters,
        bytes indexed _fallbackFunction
    );

    /// @notice Lets StorkNet know that this contract has a new Store request
    /// @param _phalanxName The address of the contract that created the new StorkDataType
    /// @param _storkIdRange The data type name keccak256-ed because that's how events work
    /// @param _fallbackFunction The data being stored
    event StorkRequestByRange(
        string indexed _phalanxName,
        uint32[] indexed _storkIdRange,
        bytes indexed _fallbackFunction
    );

    //-------------------------------------------------------------------------------------
}
