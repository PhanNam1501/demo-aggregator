// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {IDexHandlerFactory} from "./interfaces/IDexHandlerFactory.sol";
import {IAggregatorExecutor} from "./interfaces/IAggregatorExecutor.sol";
import {IERC20Permit} from "./interfaces/IERC20Permit.sol";
import {SwapMultiHop, SwapDescription} from "./structs/SAggregator.sol";
import {Address} from "./libraries/Address.sol";
import {SafeERC20} from "./libraries/SafeERC20.sol";
import {UniERC20} from "./libraries/UniERC20.sol";

contract Aggregator {
    using Address for address;
    using SafeERC20 for IERC20;
    using UniERC20 for IERC20;

    uint256 private constant _PARTIAL_FILL = 0x01;
    uint256 private constant _REQUIRES_EXTRA_ETH = 0x02;
    uint256 private constant _SHOULD_CLAIM = 0x04;
    uint256 private constant _BURN_FROM_MSG_SENDER = 0x08;
    uint256 private constant _BURN_FROM_TX_ORIGIN = 0x10;

    IDexHandlerFactory public factory;
    address public owner;

    address public immutable WETH;
    address private constant ETH_ADDRESS =
        address(0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE);

    struct SwapStep {
        address router;
        address tokenIn;
        address tokenOut;
        uint8 dexType;
        uint24 fee; // only for V3
    } // optimize struct storage slots

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner");
        _;
    }

    constructor(address _factory) {
        require(_factory != address(0), "Invalid factory address");
        factory = IDexHandlerFactory(_factory);
        owner = msg.sender;
    }

    receive() external payable {}

    // function getBalance(IERC20 token, address account) internal view returns(uint256) {
    //     token.uniBalanceOf(account);
    // }

    // function isETH(IERC20 token) internal view returns (bool iseth) {
    //     iseth = token.isETH();
    // }

    function rescueFunds(address token, uint256 amount) external onlyOwner {
        IERC20(token).uniTransfer(payable(msg.sender), amount);
    }

    function flexSwap(
        IAggregatorExecutor executor,
        SwapMultiHop calldata params,
        SwapDescription calldata desc
    ) external returns (uint256 amountOut) {
        bytes memory result = address(this).functionDelegateCall(
            abi.encodeWithSelector(this.swap.selector, executor, params, desc)
        );
        uint256 returnAmount = abi.decode(result, (uint256));
    }

    function swap(
        IAggregatorExecutor executor,
        SwapMultiHop calldata params,
        SwapDescription calldata desc
    ) external returns (uint256 amountOut) {
        uint256 flag = desc.flags;
        IERC20 tokenIn = IERC20(desc.tokenIn);
        IERC20 tokenOut = IERC20(desc.tokenOut);
        _checkShouldClaim(desc);
        tokenIn.transferFrom(msg.sender, address(this), desc.amountIn);
        uint256 balanceSrcBefore = tokenIn.uniBalanceOf(msg.sender);
        uint256 balanceDstBefore = tokenOut.uniBalanceOf(msg.sender);
        //amountOut = executor.swapMultiHop(params, desc, factory);
        bytes memory result = address(executor).functionDelegateCall(abi.encodeWithSelector(IAggregatorExecutor.swapMultiHop.selector, params, desc, factory));
        amountOut = abi.decode(result, (uint256));
        uint256 balanceSrcAfter = tokenIn.uniBalanceOf(msg.sender);
        uint256 balanceDstAfter = tokenOut.uniBalanceOf(msg.sender);

        uint256 spentAmount = balanceSrcBefore - balanceSrcAfter;
        uint256 returnAmount = balanceDstAfter - balanceDstBefore;
        amountOut = returnAmount;
        _checkReturnAmount(spentAmount, returnAmount, desc);
    }

    function _claim(IERC20 token, address dst, uint256 amount, bytes calldata permit) private {
        if (permit.length == 32 * 7) {
            (bool ok, ) = address(token).call(abi.encodeWithSelector(IERC20Permit.permit.selector, permit));
            require(ok, "Permit is failed");
        }

        token.safeTransferFrom(dst, address(this), amount);
    }

    function _checkShouldClaim(
        SwapDescription calldata desc
    ) private {
        if (_flagsChecked(desc.flags, _SHOULD_CLAIM)) {
            _claim(IERC20(desc.tokenIn), address(this), desc.amountIn, desc.permit);
        } else {

        }
    }

    function _checkReturnAmount(
        uint256 spentAmount,
        uint256 returnAmount,
        SwapDescription calldata desc
    ) internal pure {
        if (_flagsChecked(desc.flags, _PARTIAL_FILL)) {
            require(
                returnAmount * desc.amountIn >=
                    desc.minReturnAmount * spentAmount,
                "Return amount is not enough"
            );
        } else {
            require(
                returnAmount >= desc.minReturnAmount,
                "Return amount is not enough"
            );
        }
    }

    function _flagsChecked(
        uint256 number,
        uint256 flag
    ) internal pure returns (bool) {
        return number & flag != 0;
    }
}
