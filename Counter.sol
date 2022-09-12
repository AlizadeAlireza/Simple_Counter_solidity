// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

contract Counter {
    int256 public count;

    
    // function to increament count by given number
    function increase(int256 _elevator) public{
        count += _elevator;
    }

    // function to decreament count by given number
    function decrease(int256 _reducer) public{
        count -= _reducer;
    }

    modifier incFirst {
        require(count > 0 ,"First you need to increase the count");
        _;
    }

    // function to multiple count by given number
    function multiple(int256 _multi) incFirst public{
        count *= _multi;
    }

    // function to divide count by given number
    function divide(int256 _div) incFirst public{
        count /= _div;
    }
}

