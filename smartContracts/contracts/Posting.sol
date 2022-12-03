// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract Posting is ERC721, ERC721Burnable, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

    struct jobPosting {
        string position;
        string description;
        uint256 startDate;
        uint256 hourlyRate;
        string[] skills;
    }
    jobPosting[] public openPositions;

    constructor() ERC721("khaaliJaebBounty", "kJB") {}

    function safeMint(address to) public onlyOwner {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
    }

    function addJobPosting(
        string memory position, 
        string memory description, 
        uint256 startDate, 
        uint256 hourlyRate, 
        string[] memory skills
        ) public onlyOwner returns(jobPosting) {
        jobPosting posting = jobPosting(position, description, startDate, hourlyRate, skills);
        openPositions.push(posting);
        safeMint(msg.sender);
        return posting;
    }

    function acceptCandidate(uint256 jobID, string memory position) public onlyOwner returns(jobPosting) {
        require(jobID < openPositions.length);
        delete openPositions[jobID];
        _burn(jobID);
    }
}
