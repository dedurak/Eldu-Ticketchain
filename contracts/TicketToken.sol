pragma solidity >=0.6.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";


/**
*   @dev contract TicketToken
*   @author Deniz Durak
*/


contract TicketToken is ERC721, AccessControl {
    

    /**
     *  roles for granting permissions 
     *
     *  ONLY ONE ADMINISTRATOR -> deployer addr - no transfer possible
     */

    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant BURNER_ROLE = keccak256("BURNER_ROLE");



    /**
     *  @dev constructor with nft token name and symbol
     *  also setting up the admin role for deployer addr
     */ 
    constructor() public ERC721("ElduTicket", "ETKT")
    {
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }

    


}
