pragma solidity >=0.5.0;

interface IUniswapV2Pair {
   
    function swap(uint amount0Out, uint amount1Out, address to, bytes calldata data) external;
    
}