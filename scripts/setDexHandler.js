const { ethers } = require("hardhat");
const factoryAbi = require("./abi/Factory.json");


const UINT256_MAX = BigInt(2) ** BigInt(96) - BigInt(1);

require("dotenv").config();
async function main() {
    console.log("Nam");
    const privatekey = process.env.PRIVATE_KEY;
    const provider = new ethers.providers.JsonRpcProvider("https://bsc-testnet-rpc.publicnode.com");
    const wallet = new ethers.Wallet(privatekey, provider);
    console.log("Nam");

    //const [signer] = await ethers.getSigners();
    const factory = new ethers.Contract(process.env.FACTORY, factoryAbi, wallet);
    console.log("Nam");
    const tx = await factory.setDexHandler(process.env.UNISWAPV3_HANDLER);
    await tx.wait(); 

    const dex = await factory.dexHandlers(0);
    console.log(dex);



 


    
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});

