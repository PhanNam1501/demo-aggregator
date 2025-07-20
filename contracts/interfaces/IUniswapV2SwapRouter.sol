// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.7.5;

interface IUniswapV2SwapRouter {
    //Nhập vào amountIn
    struct ExactTokensForTokens {
        address[] path;
        uint256 amountToSwap;
        uint256 amountMinMax;
        bool isExactIn;
        uint256 deadline;
    }

    function swapExactTokensForTokens(
        ExactTokensForTokens calldata params
    ) external payable returns (uint256[] memory amounts);

    //Nhập amountOut mong muốn
    struct TokensForExactTokens {
        address[] path;
        uint256 amountToSwap;
        uint256 amountMinMax;
        bool isExactIn;
        uint256 deadline;
    }

    function swapTokensForExactTokens(
        TokensForExactTokens calldata params
    ) external payable returns (uint[] memory amounts);
}
