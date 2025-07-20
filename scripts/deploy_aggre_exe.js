const hre = require("hardhat");
// const { upgrades } = require("hardhat");
// const fs = require('fs');
require("dotenv").config();
async function main() {
  const AggEx = await hre.ethers.deployContract("AggregatorExecutor");
  console.log("Agg: ", AggEx.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

