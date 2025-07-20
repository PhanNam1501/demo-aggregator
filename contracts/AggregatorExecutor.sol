// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {IDexHandlerFactory} from "./interfaces/IDexHandlerFactory.sol";
import {SwapMultiHop, SwapDescription} from "./structs/SAggregator.sol";
import {Address} from "./libraries/Address.sol";
import {SafeERC20} from "./libraries/SafeERC20.sol";
import {UniERC20} from "./libraries/UniERC20.sol";

contract AggregatorExecutor {
    using Address for address;
    
    function swapMultiHop(
        SwapMultiHop calldata params,
        SwapDescription calldata desc,
        IDexHandlerFactory factory
    ) external returns(uint256 amountOut) {
        require(params.amountIn != 0, "The amount for swap is zero");
        address dexHandler;
        uint256 amountIn;

        IERC20(params.tokenIn[0]).transferFrom(msg.sender, address(this), params.amountIn);

        for (uint8 i = 0; i < params.routers.length; i++) {
            address _tokenIn = params.tokenIn[i];
            dexHandler = factory.dexHandlers(params.dexHandlerIds[i]);
            IERC20(_tokenIn).approve(params.routers[i], params.amountIn);
            bytes memory result = address(dexHandler).functionDelegateCall(abi.encodeWithSignature("executeSwap(address,bytes)", params.routers[i], params.data[i]));
            amountOut = abi.decode(result, (uint256));
            amountIn = amountOut;
        }
    }
}