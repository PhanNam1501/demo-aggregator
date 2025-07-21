// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {IUniswapV2SwapRouter} from "./interfaces/IUniswapV2SwapRouter.sol";
// import {IDexHandler} from "./interfaces/IDexHandler.sol";

contract UniswapV2Handler {
<<<<<<< Updated upstream
    function executeSwap(address router, bytes calldata data) external returns (uint256 amountOut) {
        UniswapV2SwapData memory swapData = abi.decode(data, (UniswapV2SwapData));

        IUniswapV2Router02 uniswapRouter = IUniswapV2Router02(router);

        if (swapData.isExactIn) {
            // Exact Input Swap
            uint[] memory amounts = uniswapRouter.swapExactTokensForTokens(
                swapData.amountIn,
                swapData.amountOutMin,
                swapData.path,
                address(this),
                swapData.deadline
            );
            amountOut = amounts[amounts.length - 1];
        } else {
            // Exact Output Swap
            uint[] memory amounts = uniswapRouter.swapTokensForExactTokens(
                swapData.amountOut, // từ amountIn field
                swapData.amountInMax, // từ amountOutMin field 
                swapData.path,
                address(this),
                swapData.deadline
            );
            amountOut = amounts[amounts.length - 1];
        }
=======
    function executeSwap(
        address router,
        bytes calldata data
    ) external returns (uint256 amountOut) {
        (
            uint256 amountIn,
            uint256 amountOutMin,
            address[] memory path,
            uint256 deadline
        ) = abi.decode(data, (uint256, uint256, address[], uint256));

        IUniswapV2SwapRouter uniswapRouter = IUniswapV2SwapRouter(router);

        // Exact Input Swap
        uint[] memory amounts = uniswapRouter.swapExactTokensForTokens(
            amountIn,
            amountOutMin,
            path,
            address(this),
            deadline
        );
        amountOut = amounts[amounts.length - 1];
>>>>>>> Stashed changes
    }
}
