// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

contract Counter {
    int256 public count;
    
    
    // Function to get the current count
    // function get() public view returns (int256) {
    //     // the current count is:
    //     return count;
    // }
    // count public don't need to get function
    
    
    
    modifier firstNeed {
        require(count != 0 ,"Please increase or decrease the count first.");
        _;
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

