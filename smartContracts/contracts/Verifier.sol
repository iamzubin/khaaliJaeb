// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

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

    function addExperience(address user, string proof, string skill, uint256 duration) public OnlyUser(user) {        
        employeeView[user] = Proof(proof, skill, duration);
        if(employer[user].skill == skill) {
            employer[user].duration += duration;
        } else {
            employerView[user] = Expereience(skill, duration);
        }
    }

    function deleteExperience(address user, string proof) public OnlyUser(user) {
        uint256 duration = employeeView[user].duration;
        string skill = employeeView[user].skill;
        delete employeeView[user];

        if(employerView[user].skill == skill) {
            employerView[user].duration -= duration;
        }
    }

    function getExperiences(address user) public returns(Experience[]) {
        return employerView[user];
    }
}