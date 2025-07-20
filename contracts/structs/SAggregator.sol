// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

struct UniswapV3SwapData {
    address router;
    address tokenIn;
    address tokenOut;
    uint24 fee;
    uint256 deadline;
    uint256 amountIn;
    uint256 amountOutMin;
    uint160 sqrtPriceLimitX96;
}

struct UniswapV2SwapData {
    address router;
    address[] path;
    uint256 amountToSwap;
    uint256 amountLimit;
    bool isExactIn; //true -> exactIn; false -> exactOut
    //uint24 fee;   //0.3
    uint256 deadline;
}

struct SwapMultiHop {
    address[] routers;
    uint8[] dexHandlerIds;
    address[] tokenIn;
    uint256 amountIn;
    bytes[] data;
    uint256 flags;
}