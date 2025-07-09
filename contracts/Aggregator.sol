// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {IDexHandlerFactory} from "./interfaces/IDexHandlerFactory.sol";
import {SwapMultiHop} from "./structs/SAggregator.sol";


contract Aggregator {
    IDexHandlerFactory public factory;

    struct SwapStep {
        address router;
        address tokenIn;
        address tokenOut;
        uint8 dexType; 
        uint24 fee; // only for V3 
    } // optimize struct storage slots

    constructor(address _factory) {
        require(_factory != address(0), "Invalid factory address");
        factory = IDexHandlerFactory(_factory);
    }



    function swapMultiHop(
        SwapMultiHop calldata params
    ) public returns(uint256 amountOut) {
        require(params.amountIn != 0, "The amount for swap is zero");
        address dexHandler;
        uint256 amountIn;

        IERC20(params.tokenIn[0]).transferFrom(msg.sender, address(this), params.amountIn);

        for (uint256 i = 0; i < params.routers.length; i++) {
            address _tokenIn = params.tokenIn[i];
            // address tokenOut = params[i].tokenOut; 
            dexHandler = factory.dexHandlers(params.dexHandlerIds[i]);
            IERC20(_tokenIn).approve(params.routers[i], params.amountIn);
            bytes memory dataSend = abi.encode(address(params.routers[i]), bytes(params.data[i]));
            (bool success, bytes memory result) = dexHandler.delegatecall(
                abi.encodeWithSignature("executeSwap(address,bytes)", params.routers[i], params.data[i])
            );
            require(success, "Swap failed");
            amountOut = abi.decode(result, (uint256));
            amountIn = amountOut;
        }
    }

    // function swapMultiRoute(
    //     address[] calldata routers, 
    //     uint256[] calldata dexHandlerIds,
    //     address[] calldata tokenIn,
    //     uint256[] amountIn, 
    //     bytes[] calldata data
    // ) {

    // }


}