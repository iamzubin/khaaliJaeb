// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Burnable.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "./0xPolygonID/GenesisUtils.sol";
import "./0xPolygonID/ICircuitValidator.sol";
import "./0xPolygonID/ZKPVerifier.sol";


contract Experience is ZKPVerifier, ERC721, ERC721Burnable, Ownable {

    uint64 public TRANSFER_REQUEST_ID = 1;

    struct Experience {
        bool active;
        address employer;
        address employee;
    }
    Experience[] public experiences;

    mapping(address => uint256) public userToExperience;

    function safeMint(address to, address from, string memory tokenURI) public onlyOwner {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _mint(to, tokenId, 1, "");
        userToExperience[msg.sender] = tokenId;
        _setTokenURI(tokenId, tokenURI);
        expereinces.push(Experience(true, from,to));
    }

    function _afterProofSubmit(
        uint64 requestId,
        address to,
        bytes memory link,
        uint256[] memory inputs,
        ICircuitValidator validator
    ) internal virtual {
        super._afterProofSubmit(requestId, inputs, validator);
        safeMint(msg.sender);
    }

    function startExperience(uint256 jobId) public returns(address) {
        return(jobId, msg.sender);
    }

}