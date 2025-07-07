// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import { UpgradeableBeacon } from "@openzeppelin/contracts/proxy/beacon/UpgradeableBeacon.sol";
contract FTBeacon is UpgradeableBeacon {
    constructor(address _implementation, address _owner) 
        UpgradeableBeacon(_implementation, msg.sender)
    {
        require(_implementation != address(0), "implementation is address zezo");
        require(_owner != address(0), "owner is address zero");
        _transferOwnership(_owner);
    }
}