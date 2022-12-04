// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IExperience {
    function startExperience(uint256 jobId) external returns(uint256, address);

}
