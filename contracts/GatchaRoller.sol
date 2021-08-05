// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.7.0 <0.9.0;

import "https://github.com/0xcert/ethereum-erc721/src/contracts/tokens/nf-token-metadata.sol";
import "https://github.com/0xcert/ethereum-erc721/src/contracts/ownership/ownable.sol";

contract GatchaNFT is NFTokenMetadata, Ownable {
    /**
     * @dev Contract constructor. Sets metadata extension `name` and `symbol`.
     */
    constructor() {
        nftName = "Gatcha NFT";
        nftSymbol = "GFT";
    }

    /**
     * @dev Mints a new NFT.
     * @param _to The address that will own the minted NFT.
     * @param _tokenId of the NFT to be minted by the msg.sender.
     * @param _uri String representing RFC 3986 URI.
     */
    function mint(
        address _to,
        uint256 _tokenId,
        string calldata _uri
    ) external onlyOwner {
        super._mint(_to, _tokenId);
        super._setTokenUri(_tokenId, _uri);
    }
}

contract GatchaRoller {
    // The keyword "public" makes variables
    // accessible from other contracts
    address public minter;
    mapping(address => uint256) public balances;
    mapping(address => string[]) public nfts;
    GatchaNFT private nft;

    // Constructor code is only run when the contract
    // is created
    constructor() {
        minter = msg.sender;
        // mint the NFTs and give them to "this"
        nft = GatchaNFT(msg.sender);
        nft.mint(msg.sender, 0, "test");
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
