// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {IDexHandlerFactory} from "./interfaces/IDexHandlerFactory.sol";
import {EnumerableSet} from "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";

contract DexHandlerFactory is IDexHandlerFactory {
    using EnumerableSet for EnumerableSet.AddressSet;

    EnumerableSet.AddressSet private _handlers;
    address public owner;

    event HandlersAdded(uint8 indexed id, address indexed handler);
    event HandlerRemoved(uint8 indexed id, address indexed handler);

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
        require(dexHandler != address(0), "Dex handler is zero address");

        _handlers.add(dexHandler);
        uint8 id = uint8(_handlers.length() - 1);

        emit HandlersAdded(id, dexHandler);

        return id;
    }

    function removeHandler(uint8 id) external onlyOwner {
        address handlerToRemove = _handlers.at(id);
        _handlers.remove(handlerToRemove);

        emit HandlerRemoved(id, handlerToRemove);
    }

    function dexHandlers(uint8 id) external view returns (address) {
        require(id < _handlers.length(), "Invalid handler ID");
        return _handlers.at(id);
    }
}
