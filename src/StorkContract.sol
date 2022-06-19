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

    function createPhalanxType(string memory _phalanxName)
        public
        // PhalanxType[] memory _phalanxType
        isOwner
    {
        require(phalanxExists[_phalanxName] == false, "Type already exists");

        phalanxInfo[_phalanxName].phalanxTypeId = storkTypeCount;

        // emit NewPhalanxType(
        //     storkTypeCount,
        //     _phalanxName,
        //     abi.encode(_phalanxType)
        // );
        phalanxExists[_phalanxName] == true;
        storkTypeCount++;
    }

    // event NewPhalanxType(
    //     uint256 indexed _storkTypeCount,
    //     string indexed _storkName,
    //     bytes indexed _storkData
    // );

    /// @notice Initializes your StorkContract with some ETH so that it can interact with StorkNet
    /// @dev A call function to the DCC with some ETH to initialize the StorkContract
    function contractFunding() external payable {
        (bool success, ) = storkFund.call{value: msg.value}(
            abi.encodeWithSignature("fundStorkContract(address)", this)
        );
        require(success, "Failed to fund contract");
    }
}
