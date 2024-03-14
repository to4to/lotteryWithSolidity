//SPDX License Identifier: MIT

// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.21;

import {VRFCoordinatorV2Interface} from "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";
import {VRFConsumerBaseV2} from "@chainlink/contracts/src/v0.8/vrf/VRFConsumerBaseV2.sol";
/**
 * @title  Raffle Contract
 * @author github.com/to4to
 * @notice CReating A Raffle i.e. A Lottery Contract
 * @dev Implements Chainlink VRFv2
 */
contract Raffle is VRFConsumerBaseV2 {
    error Raffle__NotEnoughETHSent();
    /**State Variable */
    uint16 private constant REQUEST_CONFIRMATIONS = 3;

    uint256 private immutable i_entranceFee;
    /**@dev Duration of the  lottery in seconds */
    uint256 private immutable i_interval;
    VRFCoordinatorV2Interface private immutable i_vrfCordinator;
    bytes32 private immutable i_gasLane;
    uint64 private immutable i_subscriptionId;
    uint32 private immutable i_callBackGasLimit;
    uint32 private constant NUM_WORDS = 1;

    uint256 private s_lastTimeStamp;
    address payable[] private s_players;
    address private s_recentWinner;

    /** Events */
    event EnteredRaffle(address indexed player);

    constructor(
        uint256 entranceFee,
        uint256 interval,
        address vrfCordinator,
        bytes32 gasLane,
        uint64 subscriptionId,
        uint32 callBackGasLimit
    ) VRFConsumerBaseV2(vrfCordinator) {
        i_entranceFee = entranceFee;
        i_interval = interval;
        s_lastTimeStamp = block.timestamp;
        i_vrfCordinator = VRFCoordinatorV2Interface(vrfCordinator);
        i_gasLane = gasLane;
        i_subscriptionId = subscriptionId;
        i_callBackGasLimit = callBackGasLimit;
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
            i_gasLane, //gasLane=keyHash
            i_subscriptionId,
            REQUEST_CONFIRMATIONS,
            i_callBackGasLimit,
            NUM_WORDS
        );
    }

    function fulfillRandomWords(
        uint256 requestId,
        uint256[] memory randomWords
    ) internal override{

uint256 indexOfWinner=randomWords[0] % s_players.length;
address payable winner=s_players[indexOfWinner];
s_recentWinner=winner;
(bool success, )=winner.call{value:address(this).balance}("");

        
    }
    /** Getter Function */

    function getEntranceFee() external view returns (uint256) {
        return i_entranceFee;
    }
}
