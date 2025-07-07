const hre = require("hardhat");
// const { upgrades } = require("hardhat");
// const fs = require('fs');
require("dotenv").config();
async function main() {
  const UniswapV3Handler = await hre.ethers.deployContract("UniswapV3Handler");
  console.log("UniswapV3Handler: ", UniswapV3Handler.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

