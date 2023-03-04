// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/security/Pausable.sol";

contract POAPtest is ERC721, Pausable, ERC721Enumerable, AccessControl {
    using Counters for Counters.Counter;
    bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");
    Counters.Counter private _tokenIdCounter;
    string public POAPURI;
    mapping (uint => string) public token2URI;
    mapping (address => bool) public testWinner;
    string testAnswers;


    constructor (string memory _testAnwsers) ERC721("TestWeb3Training", "TNFT") {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(PAUSER_ROLE, msg.sender);
        POAPURI="https://nftbits.tech/POAPs/Bootcamp2023POAP.json";
        testAnswers=_testAnwsers;
    }
    function pause() public onlyRole(PAUSER_ROLE) {
        _pause();
    }

    function unpause() public onlyRole(PAUSER_ROLE) {
        _unpause();
    }
    function takeTest(string memory _testAnswers) public{
        require(testWinner[_msgSender()]==false,"already won");
        require(keccak256(abi.encodePacked(testAnswers))==keccak256(abi.encodePacked(_testAnswers)),"wrong answer");
        uint256 tokenId = _tokenIdCounter.current();
        testWinner[_msgSender()]=true;
        _tokenIdCounter.increment();
        _safeMint(_msgSender(), tokenId);
        testWinner[_msgSender()]=true;
    }

    function tokenURI(uint256 tokenId) public view virtual override returns (string memory){
        return(POAPURI);
    }

    // The following functions are overrides required by Solidity.

    function _beforeTokenTransfer(address from, address to, uint256 tokenId, uint256 batchSize)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId, batchSize);
    }


    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable, AccessControl)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
