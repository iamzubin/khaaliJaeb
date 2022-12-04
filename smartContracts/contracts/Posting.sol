// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "./interfaces/IExperience.sol";

contract Posting is ERC721, ERC721Burnable, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

    IExperience public immutable EXPEREINCE;

    struct jobPosting {
        address employer;
        bool active;
        address assignee;
        uint256 experienceId;
    }

    mapping(uint256 => jobPosting) public offerToEmployer;

    modifier onlyEmployer(uint256 tokenId) {
        require(offerToEmployer[tokenId].employer == msg.sender);
        _;
    }

    constructor(address expereinceAddress) ERC721("khaaliJaebBounty", "kJB") {
        EXPEREINCE = IExpereince(expereinceAddress);
    }

    function safeMint(address to) public onlyOwner {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
    }

    function addJobPosting() public onlyOwner returns(jobPosting memory) {
        offerToEmployer[tokenId] = jobPosting(msg.sender, true, address(0), _tokenIdCounter.current());
        safeMint(msg.sender);
        return offerToEmployer[tokenId];
    }

    function closeJobPosting(uint256 tokenId) public onlyEmployer(tokenId) {
        require(offerToEmployer[tokenId].postStatus);
        offerToEmployer[tokenId].postStatus = false;
        _burn(tokenId);
    }

    function fulfillPosting(uint256 tokenId) public onlyEmployer(tokenId) {
        require(offerToEmployer[tokenId].postStatus);
        ( ,address assignee) = EXPEREINCE.startExperience();
        offerToEmployer[tokenId].assignee = assignee;
    }
}
