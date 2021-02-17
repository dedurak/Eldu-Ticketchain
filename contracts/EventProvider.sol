pragma solidity >= 0.5.16;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/utils/Counters.sol";


/**

    @author Deniz Durak

    @dev EvenProvider is an ERC721 NFT, administrating all events, setup by a Promoter.
         The Promoter is registered inside the Promoter Provider. Only with this registration it is possible to 
         launch events for NFT sale. 

 */

contract EventProvider is ERC721, AccessControl {

    /**
        @dev creating new Counter -> while deployment
     */
    using Counters for Counters.Counter;
    Counters.Counter private _tokenid;
    Counters.Counter private _ticketid;

    /**
        @dev each event has many tickets 
            The event is the asset and is pointing to this struct,
            which contains information about price and amount of tickets

        @param Ticket new struct for tickets
        @param _owner the owner of the ticket
     */
     struct EventController {
        uint128 amount_avail;
        uint128 amount_booked;
        uint256 price; /// each id pointing to the event is unique
     }

     /**
     
      */
    struct Ticket {
        uint id;
        address owner;
        Paid proof;
    }


    enum Paid {
        PAID, NOTPAID
    }

    mapping (Proof => uint) prover;

    /**
        @dev new role for minting and burning events and this way new tokens    
    */
    bytes32 private constant MINT_ROLE = keccak256("MINTER_ROLE");
    bytes32 private constant BURN_ROLE = keccak256("BURN_ROLE");


    /**
        @dev new role for superuser -> su's gonna be deployer addr
     */
    bytes32 private constant SU_ROLE = keccak256("SU_ROLE");

    // evtickets eventid pointing to all launched tickets
    mapping (uint256 => uint128) private evtickets; 

    // mapping event to booked ticket nfts
    mapping(uint256 => Tickets[]) private bookedTickets;

    // __tokenURIs ticket id mapping to tokenURI (optional)
    mapping (uint256 => string) private __tokenURIs;


    /**
        @dev constructor
     */
    constructor() ERC721("Eldoticket", "ELT") {
        _setupRole(SU_ROLE, msg.sender);
    }


    /**
        @dev Look at {ERC721 - balanceOf}
     */
    function _balanceOf(address owner) public view returns(uint256) {
        return balanceOf(owner);
    }


    /**
        @dev create new event
        @param amount amount of available tickets
        @param price price for each ticket
        @param _tokenuri tokenuri for the new event
     */

    function createEvent(uint128 amount, uint128 price, string memory _tokenuri) 
    public returns (uint _evid) {
        
        /// check if sender has required role
        require(hasRole(MINT_ROLE, msg.sender), "No permission");

        _tokenid.increment();

        _evid = _tokenid.current();

        _safeMint(msg.sender, _evid);
        _setTokenURI(_evid, _tokenuri);

        evtickets[_evid] = new EventController(amount, 0, price);
    }




}
 