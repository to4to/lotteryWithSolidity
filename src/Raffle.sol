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
    error Raffle__NotEnoughETHSent();

    uint256 private immutable i_entranceFee;
    uint256 private immutable i_interval;
    address payable[] private s_players;

/** Events */
event EnteredRaffle(address indexed player);


    constructor(uint256 entranceFee,uint256 interval) {
        i_entranceFee = entranceFee;
        i_interval=interval;
    }

    function enterRaffle() external payable {
        //require (msg.value >=i_entranceFee,"Not Enough Eth Sent!");

        if (msg.value < i_entranceFee) {
            revert Raffle__NotEnoughETHSent();
        }
         s_players.push(payable(msg.sender));
            emit EnteredRaffle(msg.sender);
    }

    function pickWinner() external {


         




    }

    /** Getter Function */

    function getEntranceFee() external view returns (uint256) {
        return i_entranceFee;
    }
}
