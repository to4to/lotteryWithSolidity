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

uint256 private immutable i_entranceFee;
constructor(uint256 entranceFee){
    i_entranceFee=entranceFee;
}

    function enterRaffle()  public payable {
        
    }


    function pickWinner() public{

    }



}