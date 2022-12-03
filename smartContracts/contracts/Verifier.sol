// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./0xPolygonID/GenesisUtils.sol";
import "./0xPolygonID/ICircuitValidator.sol";
import "./0xPolygonID/ZKPVerifier.sol";


contract khaaliJaebVerifier is ZKPVerifier {

    uint64 public transfer_request_id = 1;

}

contract verifier {

    enum jobType {
        JOB,
        BOUNTY
    }

    modifier OnlyUser(address user) {
        require(msg.sender == user);
        _;
    }

    struct Experience {
        string skill;
        uint256 duration;
    }

    mapping(address => Experience) public employerView;

    struct Proof {
        string proof;
        string skill;
        uint256 duration;
    }

    mapping(address => Proof) public employeeView;

    function addExperience(address user, string memory proof, string memory skill, uint256 duration) public OnlyUser(user) {        
        employeeView[user] = Proof(proof, skill, duration);
        if(compareStrings(employeeView[user].skill,skill)) {
            employerView[user].duration += duration;
        } else {
            employerView[user] = Experience(skill, duration);
        }
    }

    function deleteExperience(address user, string memory proof) public OnlyUser(user) {
        uint256 duration = employeeView[user].duration;
        string memory skill = employeeView[user].skill;

        if(compareStrings(employeeView[user].proof,proof)) {
            delete employeeView[user];
        }

        if(compareStrings(employerView[user].skill,skill)) {
            employerView[user].duration -= duration;
        }
    }

    function getExperiences(address user) public view returns(Experience memory) {
        return employerView[user];
    }

    function compareStrings(string memory a, string memory b) public pure returns (bool) {
        return (keccak256(abi.encodePacked((a))) == keccak256(abi.encodePacked((b))));
    }
}