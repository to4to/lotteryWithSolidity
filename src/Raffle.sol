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
    /**@dev Duration of the  lottery in seconds */
    uint256 private immutable i_interval;
    uint256  private immutable i_vrfCordinator;
bytes32    private immutable i_gasLane;


    uint256 private s_lastTimeStamp;
    address payable[] private s_players;

    /** Events */
    event EnteredRaffle(address indexed player);




    constructor(uint256 entranceFee, uint256 interval,address vrfCordinator,bytes32 gasLane) {
        i_entranceFee = entranceFee;
        i_interval = interval;
        s_lastTimeStamp = block.timestamp;
        i_vrfCordinator=vrfCordinator;
        i_gasLane=gasLane;
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
        //check to see enough time is passed
        if ((block.timestamp - s_lastTimeStamp) < i_interval) {
            revert();
        }


        // 1.Request the RNG
        // 2. Get the Random Number

       uint256 requestId = i_vrfCordinator.requestRandomWords(
            i_gasLane,//gasLane=keyHash
            s_subscriptionId,
            requestConfirmations,
            callbackGasLimit,
            numWords
        );
    }

    /** Getter Function */

    function getEntranceFee() external view returns (uint256) {
        return i_entranceFee;
    }
}
