// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "./StorkQueries.sol";

/// @custom: Data Control Contract is called DCC

/// @title Stork Handler Contract
/// @author Shankar "theblushirtdude" Subramanian
/// @notice Used to connect a StorkContract to StorkNet
/// @dev
contract StorkContract is StorkQueries {
    /// @notice Address of the DCC
    address public dataControlContract;

    /// @notice Sets the address of the DCC
    /// @dev If the address is not set, then set the address of the DCC
    /// @param _addr address of the DCC
    function setDataControlConractAddr(address _addr) internal {
        require(
            dataControlContract == address(0),
            "DataControlContract addr already set"
        );
        dataControlContract = _addr;
    }

    /// @notice Initializes your StorkContract with some ETH so that it can interact with StorkNet
    /// @dev A call function to the DCC with some ETH to initialize the StorkContract
    function contractFunding() external payable {
        (bool success, ) = dataControlContract.call{value: msg.value}(
            abi.encodeWithSignature("fundStorkContract(address)", this)
        );
        require(success, "Failed to fund contract");
    }

    /// @notice Returns the number of transactions that can be made by this StorkContract
    /// @dev STATICCALL to the DCC to get the number of txLeft of the StorkContract
    /// @return uint256 for the number of Txns left that can be made
    function txsLeft() public view returns (uint256) {
        (bool success, bytes memory data) = dataControlContract.staticcall(
            abi.encodeWithSignature("txLeftStorkContract(address)", this)
        );

        require(success, "Failed to get txs left");

        // As the data is in bytes, we need to decode it to uint256
        return (abi.decode(data, (uint256)));
    }

    /// @notice Converts a Phalanx data types to a bytes array for easier use as a parameter/event value
    /// @dev A bytes version is preferable as it's easier to handle
    /// @param _data a parameter just like in doxygen (must be followed by parameter name)
    function encodeTypes(StorkType[] calldata _data)
        public
        pure
        returns (bytes memory)
    {
        return (abi.encode(_data));
    }

    /// @notice Converts the bytes array to a StorkDataType
    /// @dev Decoding back to extract the data types, variable names, and indexes if any
    /// @param _data Bytes version of the StorkDataType
    /// @return StorkDataType conversion of the bytes array version
    function decodeTypes(bytes calldata _data)
        public
        pure
        returns (StorkType[] memory)
    {
        return (abi.decode(_data, (StorkType[])));
    }

    // FIX COMMENTS

    /// @notice Converts the bytes array to a StorkDataType
    /// @dev Decoding back to extract the data types, variable names, and indexes if any
    /// @param _data Bytes version of the StorkDataType
    /// @return StorkDataType conversion of the bytes array version
    function storkDecode(bytes calldata _data)
        internal
        pure
        returns (uint32, bytes memory)
    {
        return (abi.decode(_data, (uint32, bytes)));
    }
}
