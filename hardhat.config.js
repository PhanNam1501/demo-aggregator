require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();
require('@openzeppelin/hardhat-upgrades');
require("@nomiclabs/hardhat-ethers");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: {
    compilers: [
      {
        version: "0.8.24",
      },
      {
        version: "0.8.20",
      },
      {
        version: "0.8.0",
      },
      {
        version: "0.6.6",
      },
      {
        version: "0.5.16",
        settings: {
          optimizer: {
            enabled: true,
            runs: 200,
          }

        },
      },
    ],
  },
  networks: {
    bscTestnet: {
      url: "https://bsc-testnet-rpc.publicnode.com",
      chainId: 97,
      accounts: process.env.PRIVATE_KEY ? [process.env.PRIVATE_KEY] : [],
      hardfork: "cancun",
    },
    sepolia: {
      url: "https://eth-sepolia.public.blastapi.io",
      chainId: 11155111,
      accounts: process.env.PRIVATE_KEY ? [process.env.PRIVATE_KEY] : [],
      hardfork: "cancun",
    },
    rynn: {
      url: "https://rynn-2747220808242000-1.jsonrpc.sagarpc.io",
      chainId: 2747220808242000,
      accounts: process.env.SAGA_PK ? [process.env.SAGA_PK] : [],
    },
  },

  etherscan: {
    apiKey: {
      'rynn': 'empty'
    },
    customChains: [
      {
        network: "rynn",
        chainId: 2747220808242000,
        urls: {
          apiURL: "https://api-rynn-2747220808242000-1.sagaexplorer.io/api",
          browserURL: "https://rynn-2747220808242000-1.sagaexplorer.io:443"
        }
      }
    ]
  }
};
