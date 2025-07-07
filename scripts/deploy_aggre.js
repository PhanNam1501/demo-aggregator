const hre = require("hardhat");
// const { upgrades } = require("hardhat");
// const fs = require('fs');
require("dotenv").config();
async function main() {
  const Agg = await hre.ethers.deployContract("Aggregator");
  console.log("Agg: ", Agg.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

