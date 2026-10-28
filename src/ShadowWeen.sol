// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

/**
 * @title ShadowWeen Token
 * @dev A fully decentralized and immutable ERC20 token with no owner or admin privileges.
 */
contract ShadowWeen is ERC20 {

    // Immutable variables now strictly follow the SCREAMING_SNAKE_CASE convention
    bytes32 public immutable HALLOWEEN_SECRET_HASH;
    
    // Tracking map to prevent double-claiming candy rewards
    mapping(address => bool) public candyClaimed;

    event CandyClaimed(address indexed player, uint256 amount);

    /**
     * @dev Initializes the contract with a fixed name, symbol, and secret hash.
     * @param _secretHash The cryptographic hash required to unlock the candy claim function.
     */
    constructor(bytes32 _secretHash) ERC20("ShadowWeen", "SDW") {
        HALLOWEEN_SECRET_HASH = _secretHash;
        
        // Initial supply minted to the deployer (1,000,000 tokens with 18 decimals)
        _mint(msg.sender, 1000000 * 10**decimals());
    }

    /**
     * @notice Distributes token rewards autonomously if the correct secret is provided.
     * @param guessedSecret The raw secret string passed by the user to be hashed and verified.
     */
    function claimCandySimple(bytes32 guessedSecret) external {
        require(!candyClaimed[msg.sender], "You have already claimed your candy!");
        require(keccak256(abi.encodePacked(guessedSecret)) == HALLOWEEN_SECRET_HASH, "Incorrect Halloween secret code!");

        candyClaimed[msg.sender] = true;
        
        // The contract autonomously mints 31 SDW tokens without any administrative oversight
        _mint(msg.sender, 31 * 10**decimals());

        emit CandyClaimed(msg.sender, 31 * 10**decimals());
    }
}

