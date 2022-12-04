// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Counters.sol";
import "./0xPolygonID/GenesisUtils.sol";
import "./0xPolygonID/ICircuitValidator.sol";
import "./0xPolygonID/ZKPVerifier.sol";

import "./interfaces/IkhaaliJaebOrganization.sol";

contract khaaliJaebOrganization is IkhaaliJaebOrganization {

  using Counters for Counters.Counter;
  Counters.Counter private _tokenIds;

  mapping(uint256 => address) public idToOrganization;


  modifier onlyHolder(uint256 tokenId) {
    require(idToOrganization[tokenId] == msg.sender);
    _;
  }

  constructor() ERC721Metadata{"khaaliJaebOrganization", "kJO"} {}

  function _beforeProofSubmit(
    uint64 requestId,
    uint256[] memory inputs,
    ICircuitValidator validator
  ) internal override {
    super._beforeProofSubmit(requestId, inputs, validator);
  }

  function _afterProofSubmit(
    uint64 requestId,
    uint256[] memory inputs,
    ICircuitValidator validator
  ) internal override {
    super._afterProofSubmit(requestId, inputs, validator);
    proofs[msg.sender()][requestId] = true;
    // Mint now
    uint256 newTokenId = _tokenIds.current();
    _tokenIds.increment();
    _safeMint(msg.sender(), newTokenId);
    idToOrganization[newTokenId] = msg.sender();
  }

  function setURI(
    uint256 _id, 
    string memory _uri
  ) external onlyHolder(_id) {
    _setTokenURI(_id, _uri);
  }



}