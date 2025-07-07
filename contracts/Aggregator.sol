// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
// import {IUniswapV3SwapRouter} from "./interfaces/IUniswapV3SwapRouter.sol";
// import {IDexHandler} from "./interfaces/IDexHandler.sol";

contract Aggregator {

    struct SwapStep {
        address router;
        address tokenIn;
        address tokenOut;
        uint8 dexType; 
        uint24 fee; // only for V3 
    } // optimize struct storage slots

    function swapMultiHop(
        address[] calldata routers, 
        address[] calldata dexHandlers,
        address[] calldata tokenIn,
        uint256 amountIn, 
        bytes[] calldata data
    ) public returns(uint256 amountOut) {
        require(amountIn != 0, "The amount for swap is zero");

        IERC20(tokenIn[0]).transferFrom(msg.sender, address(this), amountIn);

        for (uint256 i = 0; i < routers.length; i++) {
            address _tokenIn = tokenIn[i];
            // address tokenOut = params[i].tokenOut;
            IERC20(_tokenIn).approve(routers[i], amountIn);
            bytes memory dataSend = abi.encode(address(routers[i]), bytes(data[i]));
            (bool success, bytes memory result) = dexHandlers[i].delegatecall(
                abi.encodeWithSignature("executeSwap(address,bytes)", routers[i], data[i])
            );
            require(success, "Swap failed");
            // amountOut = abi.decode(result, (uint256));
            // amountIn = amountOut;
        }
    }


}