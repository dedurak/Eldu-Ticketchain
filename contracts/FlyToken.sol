pragma solidity >=0.5.16;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

/**
*   @author Deniz Durak
*   @dev    FLYHigh is a ERC20 token to pay the NFTs with
*           All interests h
 */

contract FLYHigh is ERC20 {
    
    // constructor, calling super constructor of ERC20, including the 
    // initial supply
    constructor(uint256 initSupply) public ERC20("FlyHigh", "FLY") {
        _mint(msg.sender, initSupply);
    }
}