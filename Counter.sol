// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

contract Counter {
    uint256 public count;

    // Function to get the current count
    // function get() public view returns (uint256) {
    //     // the current count is:
    //     return count;
    // }
    // count public don't need to get function

    // function to increament count by 1
    function increase(uint256 _elevator) public {
        count += _elevator;
    }

    // function to decreament count by 1
    function decrease(uint256 _reducer) public {
        count -= _reducer;
    }
}
