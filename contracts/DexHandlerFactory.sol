// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {IDexHandlerFactory} from "./interfaces/IDexHandlerFactory.sol";
import {EnumerableSet} from "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";

contract DexHandlerFactory is IDexHandlerFactory {
    mapping(uint8 => address) public dexHandlers;
    address public owner;
    uint8 public id;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function setDexHandler(
        address dexHandler
    ) external onlyOwner returns (uint8) {
        dexHandlers[id] = dexHandler;
        id++;
    }
}
