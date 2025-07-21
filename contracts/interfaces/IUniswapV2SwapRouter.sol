// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.7.5;

interface IUniswapV2SwapRouter {
    // Exact Input Swap
    function swapExactTokensForTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address recipient,
        uint deadline
    ) external returns (uint[] memory amounts);

    // //Import Exact Output
    // function swapTokensForExactTokens(
    //     uint amountOut,
    //     uint amountInMax,
    //     address[] calldata path,
    //     address to,
    //     uint deadline
    // ) external returns (uint[] memory amounts);
}
