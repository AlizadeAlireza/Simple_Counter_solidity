// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "./PriceConverter.sol";

contract Counter {

    using PriceConverter for uint256;
    int256 public count;
    uint256 public constant MINIMUMUSD = 50 * 1e18;
    address[] public funders;

    mapping ( address => uint256) public addressToAmount;

    modifier firstNeed {
        require(fundMe(),"Please charge the contract.")
        require(count != 0 ,"Please increase or decrease the count first.");
        _;
    }
    
    function fundMe() public payable {
        require(msg.value.getConversionRate() > MINIMUMUSD, "Didn't send enouph ETH!")
        funders.push(msg.sender);
        addressToAmount[msg.sender] = msg.value;
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
    function increase(int256 _elevator) public{
        count += _elevator;
    }

    // function to decreament count by given number
    function decrease(int256 _reducer) public{
        count -= _reducer;
    }

    
    // function to multiply count by given number
    function multiply(int256 _modulus) firstNeed public{
        count *= _modulus;
    }

    // function to divide count by given number
    function divide(int256 _div) firstNeed public{
        count /= _div;
    }
}

