// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Burnable.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "./0xPolygonID/GenesisUtils.sol";
import "./0xPolygonID/ICircuitValidator.sol";
import "./0xPolygonID/ZKPVerifier.sol";


contract khaaliJaebExperience is ZKPVerifier, ERC1155URIStorage {

    uint64 public TRANSFER_REQUEST_ID = 1;
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCounter;

    struct Experience {
        bool active;
        address employer;
        address employee;
    }
    Experience[] public experiences;

    mapping(address => uint256) public userToExperience;

    constructor() ERC1155("khaaliJaebExperience") {}

    function safeMint(address to, address from, string memory tokenURI) public onlyOwner {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _mint(to, tokenId, 1, "");
        userToExperience[msg.sender] = tokenId;
        // _setTokenURI(tokenId, tokenURI); @dev to fix!
        experiences.push(Experience(true, from,to));
    }

    function _beforeProofSubmit(
        uint64 requestId,
        uint256[] memory inputs,
        ICircuitValidator validator
    ) internal override {
        super._beforeProofSubmit(requestId, inputs, validator);
    }

    function _afterProofSubmit(
        uint64 requestId,
        address to,
        bytes memory link,
        uint256[] memory inputs,
        ICircuitValidator validator
    ) internal virtual {
        super._afterProofSubmit(requestId, inputs, validator);
        // safeMint(msg.sender);
        // TODO add an amount for the token, not mint a new token
    }

    function startExperience(uint256 jobId) public returns(uint256, address) {
        return(jobId, msg.sender);
    }

}