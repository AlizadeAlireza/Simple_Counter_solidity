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

    // function to increament count by 1
    function increase(int256 _elevator) public {
        count += _elevator;
    }

    // function to decreament count by 1
    function decrease(int256 _reducer) public {
        count -= _reducer;
    }
}
