// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.7.0 <0.9.0;

contract GatchaRoller {
    // The keyword "public" makes variables
    // accessible from other contracts
    address public minter;
    mapping(address => uint256) public balances;
    mapping(address => string[]) public nfts;

    // Constructor code is only run when the contract
    // is created
    constructor() {
        minter = msg.sender;
        // mint the NFTs and give them to "this"
    }

    // Sends an amount of newly created coins to an address
    // Can only be called by the contract creator
    function vendRollToken(address receiver, uint256 amount) public {
        require(msg.sender == minter);
        require(amount < 1e60);
        balances[receiver] += amount;
    }

    function roll() public {
        require(balances[msg.sender] > 1, "you must have at least 1 token");
        balances[msg.sender] -= 1;

        bytes32 bHash = blockhash(block.number - 1);
        uint8 rand = uint8(
            uint256(
                keccak256(abi.encodePacked(block.timestamp, bHash, uint256(14)))
            ) % 5
        );
        if (rand == 0) {
            // transfer ownership of the NFT
        }
    }
}
