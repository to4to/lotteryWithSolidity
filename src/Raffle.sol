//SPDX License Identifier: MIT

// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.22;

/**
 * @title  Raffle Contract
 * @author github.com/to4to
 * @notice CReating A Raffle i.e. A Lottery Contract
 * @dev Implements Chainlink VRFv2
 */
contract Raffle {

error NotEnoughETHSent();

    uint256 private immutable i_entranceFee;

    constructor(uint256 entranceFee) {
        i_entranceFee = entranceFee;
    }

    function enterRaffle() external payable {
//require (msg.value >=i_entranceFee,"Not Enough Eth Sent!");

if(msg.value<i_entranceFee){
    revert NotEnoughETHSent();
}
    }

    function pickWinner() public {}

    /** Getter Function */

    function getEntranceFee() external view returns (uint256) {
        return i_entranceFee;
    }
}
