// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.7.0;

contract MySmartContract {
    function Hello() public pure returns (string memory) {
        return "Hello World";
    }

    function Greet(string memory str) public pure returns (string memory) {
        return str;
    }
}
