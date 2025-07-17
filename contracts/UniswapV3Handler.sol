// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {IUniswapV3SwapRouter} from "./interfaces/IUniswapV3SwapRouter.sol";
// import {IDexHandler} from "./interfaces/IDexHandler.sol";



contract UniswapV3Handler {
    function executeSwap(address router, bytes calldata data) external returns (uint256 amountOut) {
        (
            address tokenIn, 
            address tokenOut,
            uint24 fee,
            uint256 deadline,
            uint256 amountIn,
            uint256 amountOutMinimum,
            uint160 sqrtPriceLimitX96
        ) = 
            abi.decode(data, (address, address, uint24, uint256, uint256, uint256, uint160));

        IUniswapV3SwapRouter.ExactInputSingleParams memory param = IUniswapV3SwapRouter.ExactInputSingleParams({
            tokenIn: tokenIn,
            tokenOut: tokenOut,
            fee: fee,
            recipient: address(this),
            deadline: deadline,
            amountIn: amountIn,
            amountOutMinimum: amountOutMinimum,
            sqrtPriceLimitX96: sqrtPriceLimitX96
        });
       
        

        amountOut = IUniswapV3SwapRouter(router).exactInputSingle(param);

        // amountOut = IUniswapV3SwapRouter(router).exactInputSingle(param);
        // (bool success, bytes memory data) = router.call(
        //     abi.encodeWithSelector(
        //         IUniswapV3SwapRouter.exactInputSingle.selector,
        //         param
        //     )
        // );

        // require(success, "Swap failed");
    }
}