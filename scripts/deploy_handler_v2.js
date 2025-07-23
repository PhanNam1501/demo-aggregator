const hre = require("hardhat");
// const { upgrades } = require("hardhat");
// const fs = require('fs');
require("dotenv").config();
async function main() {
    const UniswapV2Handler = await hre.ethers.deployContract("UniswapV2Handler");
    console.log("UniswapV2Handler: ", UniswapV2Handler.address);
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});

