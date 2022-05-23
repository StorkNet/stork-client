// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./StorkQueries.sol";

/// @custom: Data Control Contract is called DCC
/// @custom: Multi Sig Verfication Contract is called MSVC

/// @title Stork Handler Contract
/// @author Shankar "theblushirtdude" Subramanian
/// @notice Used to connect a StorkContract to StorkNet
/// @dev
contract StorkContract is StorkQueries {
    modifier isOwner() {
        require(msg.sender == owner, "is not owner");
        _;
    }

    /// @notice Address of stork fund
    address payable public storkFund;

    /// @notice Address of the contract owner
    address public owner;

    /// @notice Sets the address of the DCC and MSVC
    /// @dev If the address is not set, set the addresses for DCC and MSVC
    /// @param _storkFund address of the DCC
    function storkSetup(address payable _storkFund) public payable {
        // check if the address is null
        require(storkFund == address(0), "StorkContract already initialized");

        (, bytes memory storkQueryAddrBytes) = _storkFund.staticcall(
            abi.encodeWithSignature("getStorkQueryAddr()")
        );
        storkQuery = StorkQuery(abi.decode(storkQueryAddrBytes, (address)));

        // gets the minimum stake amount from the DCC
        (, bytes memory minStakeBytes) = _storkFund.staticcall(
            abi.encodeWithSignature("getMinFundValue()")
        );

        uint256 minStake = abi.decode(minStakeBytes, (uint256));

        // checks if the msg.value is greater than the minimum stake amount
        require(
            msg.value > minStake,
            "Not enough stake value, check minStake at DCC"
        );

        // perform the transaction
        (bool success, ) = _storkFund.call{value: msg.value}(
            abi.encodeWithSignature("addStorkContract()")
        );
        require(success, "Failed to add stork contract");

        // if the transaction is successful, set the address of the DCC
        storkFund = _storkFund;
    }

    /// @notice Initializes your StorkContract with some ETH so that it can interact with StorkNet
    /// @dev A call function to the DCC with some ETH to initialize the StorkContract
    function contractFunding() external payable {
        (bool success, ) = storkFund.call{value: msg.value}(
            abi.encodeWithSignature("fundStorkContract(address)", this)
        );
        require(success, "Failed to fund contract");
    }

    /// @notice Returns the number of transactions that can be made by this StorkContract
    /// @dev STATICCALL to the DCC to get the number of txLeft of the StorkContract
    /// @return uint256 for the number of Txns left that can be made
    function txsLeft() public view returns (uint256) {
        (bool success, bytes memory data) = storkFund.staticcall(
            abi.encodeWithSignature("txLeftStorkContract(address)", this)
        );

        require(success, "Failed to get txs left");

        // As the data is in bytes, we need to decode it to uint256
        return (abi.decode(data, (uint256)));
    }

    /// @notice Converts Phalanx types to a bytes array for easier use as a parameter/event value
    /// @dev A bytes version is preferable as it's easier to handle
    /// @param _data Phalanx type array that contains information about the data type
    function encodeTypes(PhalanxType[] memory _data)
        public
        pure
        returns (bytes memory)
    {
        return (abi.encode(_data));
    }

    /// @notice Converts the bytes array to a Phalanx type
    /// @dev Decoding back to extract the data types, variable names, and indexes if any
    /// @param _data Bytes version of the Phalanx type
    /// @return Phalax type in bytes
    function decodeTypes(bytes calldata _data)
        public
        pure
        returns (PhalanxType[] memory)
    {
        return (abi.decode(_data, (PhalanxType[])));
    }

    /// @notice Decodes into a Stork
    /// @dev Decodes the Stork from bytes to Stork {_id, _phalanxType, _data}
    /// @param _data bytes version of a Stork
    /// @return _id and _data of the Stork requested for
    function storkDecode(bytes calldata _data)
        internal
        pure
        returns (uint32, bytes memory)
    {
        return (abi.decode(_data, (uint32, bytes)));
    }

    /// @notice Creates a new StorkNet data type based on the parameters given
    /// @dev Links the StorkNet data type with unique name and id, then emits an event for off-chain processing
    /// @param _phalanxName The name of the StorkNet data type
    /// @param _phalanxType The new StorkNet data type


    /// @notice Lets StorkNet know that a new data type has been created for this contract
    /// @dev This is so that we don't need to store the data type in this contract as they take a lot of space hence gas
    /// @param _storkTypeCount The id of the created StorkDataType
    /// @param _phalanxName The data type name keccak256-ed because that's how events work
    /// @param _storkData The bytes version of the StorkDataType

}