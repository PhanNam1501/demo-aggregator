// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

struct UniswapV3SwapData{
    address router;
    uint256 tokenIn;
    uint256 tokenOut;
    uint24 fee;
    uint256 dealine;
    uint256 amountIn;
    uint256 amountOutMin;
    uint160 sqrtPriceLimitX96;
}

struct SwapMultiHop {
    address[] routers; 
    uint8[] dexHandlerIds;
    address[] tokenIn;
    uint256 amountIn;
    bytes[] data;
    uint256 flags;
}