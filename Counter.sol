// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "./PriceConverter.sol";
import "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";
import "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";
import "@chainlink/contracts/src/v0.8/interfaces/KeeperCompatibleInterface.sol";

contract Counter is
    VRFConsumerBaseV2,
    KeeperCompatibleInterface,
    KeeperCompatibleInterface
{
event requestedCounterNumber(uint256 indexed requestId);
    using PriceConverter for uint256;
    int256 public count;
    uint256 public constant MINIMUMUSD = 1 * 1e18;
    address[] public funders;
    address public immutable owner;

    // random variables
    VRFCoordinatorV2Interface private immutable i_vrfCoordinator;
    uint256 private immutable i_entranceFee;
    bytes32 private immutable i_gasLane; //keyHash
    uint64 private immutable i_subscriptionId;
    uint32 private immutable i_callbackGaslimit;
    uint16 private constant REQUEST_CONFIRMATIONS = 3;
    uint32 private constant NUM_WORDS = 1;


    modifier firstNeed() {
        require(securityCheck(msg.sender), "Please charge the contract.");
        require(count != 0, "Please increase or decrease the count first.");
        _;
    }

    constructor(
        address vrfCoordinator,
        uint256 entranceFee,
        bytes32 gasLane,
        uint64 subscriptionId,
        uint32 callbackGaslimit
    ) VRFConsumerBaseV2(vrfCoordinatorV2) {
        i_vrfCoordinator = VRFCoordinatorV2Interface(vrfCoordinator);
        i_entranceFee = entranceFee;
        i_gasLane = gasLane;
        i_subscriptionId = subscriptionId;
        i_callbackGaslimit = callbackGaslimit;
    }

    function fundMe() public payable {
        require(
            msg.value.getConversionRate() >= MINIMUMUSD,
            "Didn't send enough ETH!"
        );
        funders.push(msg.sender);
    }

    // function to increament count by 1
    function increaseByOne() public {
        count += 1;
    }

    // function to decreament count by 1
    function decreaseByOne() public {
        count -= 1;
    }

    // function to increament count by given number
    function increase(int256 _elevator) public firstNeed {
        count += _elevator;
    }

    // function to decreament count by given number
    function decrease(int256 _reducer) public firstNeed {
        count -= _reducer;
    }

    // function to multiply count by given number
    function multiply(int256 _modulus) public firstNeed {
        count *= _modulus;
    }

    // function to divide count by given number
    function divide(int256 _div) public firstNeed {
        count /= _div;
    }

    function securityCheck(address name) internal view returns (bool) {
        for (uint256 data = 0; data < funders.length; data++) {
            if (funders[data] == name) {
                return true;
            }
        }
        return false;
    }

    function requestRandomWords() public {
    	uint256 requestId = i_vrfCoordinator.requestRandomWords(
            i_gasLane, //gasLane
            i_subscriptionId,
            REQUEST_CONFIRMATIONS,
            i_callbackGasLimit,
            NUM_WORDS
        );
        emit RequestedCounterNumber(requestId);
    }

    function fulfillRandomWords(
        uint256, /*requestId*/
        uint256[] memory randomWords
    ) internal override returns (uint256) {
        return randomWords[0];
    }
}
