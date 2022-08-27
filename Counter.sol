// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

contract Counter {
    uint256 public count;

    // Function to get the current count
    function get() public view returns (uint256) {
        // the current count is:
        return count;
    }

    // function to increament count by 1
    function increase() public {
        count += 1;
    }

    // function to decreament count by 1
    function decrease() public {
        count -= 1;
    }
}
