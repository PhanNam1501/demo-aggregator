const hre = require("hardhat");
// const { upgrades } = require("hardhat");
// const fs = require('fs');
require("dotenv").config();
async function main() {
  const Factory = await hre.ethers.deployContract("DexHandlerFactory");
  console.log("Agg: ", Factory.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

