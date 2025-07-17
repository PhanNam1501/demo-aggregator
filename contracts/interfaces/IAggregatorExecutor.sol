// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {IDexHandlerFactory} from "./IDexHandlerFactory.sol";
import {SwapMultiHop} from "../structs/SAggregator.sol";

interface IAggregatorExecutor {
    function swapMultiHop(
        SwapMultiHop calldata params,
        IDexHandlerFactory factory
    ) external returns (uint256 amountOut);
}
