// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "./0xPolygonID/GenesisUtils.sol";
import "./0xPolygonID/ICircuitValidator.sol";
import "./0xPolygonID/ZKPVerifier.sol";

contract Organization is ZKPVerifier, ERC721, ERC721Burnable, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

    mapping(address => uint256) public orgToToken;

    modifier onlyEmployer(uint256 tokenId) {
        require(orgToToken[msg.sender] == tokenId);
        _;
    }

    constructor() ERC721("khaaliJaebCompany", "kJC") {}

    function safeMint(address to, bytes memory link, string memory tokenURI) public onlyOwner {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId, link);
        orgToToken[msg.sender] = tokenId;
        _setTokenURI(tokenId, tokenURI);
    }

    function _afterProofSubmit(
        uint64 requestId,
        address to,
        bytes memory link,
        uint256[] memory inputs,
        ICircuitValidator validator
    ) internal virtual {
        super._afterProofSubmit(requestId, inputs, validator);
        safeMint(to, link);
    }

    function addOrganizationLink(bytes memory link) public onlyEmployer(tokenId) {
        safeMint(msg.sender, link);
    }
}
