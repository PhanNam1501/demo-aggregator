// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

interface IDexHandlerFactory {
    // Các hàm public/external cần expose ra ngoài
    function dexHandlers(uint8) external view returns (address);  // Mapping tự động tạo getter public
    function owner() external view returns (address);             // State variable public
    function id() external view returns (uint8);                 // State variable public
    
    function setDexHandler(address dexHandler) external returns (uint8);
}