const { ethers } = require("hardhat");
const aggAbi = require("./abi/Agg.json");
const erc20Abi = require("./abi/ERC20.json");


const UINT256_MAX = BigInt(2) ** BigInt(96) - BigInt(1);

require("dotenv").config();

async function main() {
    const privatekey = process.env.PRIVATE_KEY;
    const provider = new ethers.providers.JsonRpcProvider("https://bsc-testnet-rpc.publicnode.com");
    const wallet = new ethers.Wallet(privatekey, provider);

    //const [signer] = await ethers.getSigners();
    const agg = new ethers.Contract(process.env.AGGREGATOR, aggAbi, wallet);



    const token0 = new ethers.Contract(process.env.TOKENA, erc20Abi, wallet);
    const token1 = new ethers.Contract(process.env.TOKENB, erc20Abi, wallet);
    const agg_address = process.env.AGGREGATOR;

    console.log("Token0", await token1.balanceOf(process.env.AGGREGATOR_EXECUTOR));
    

    // const tx1 = await token0.approve(agg_address, 100);
    // await tx1.wait();

    // const tx2 = await token1.approve(agg_address, 100);
    // await tx2.wait();




    // const data = ethers.utils.defaultAbiCoder.encode(
    //     ["address", "address", "uint24", "uint256", "uint256", "uint256", "uint160"],
    //     [
    //         process.env.TOKENA,
    //         process.env.TOKENB,
    //         500,
    //         UINT256_MAX,
    //         10,
    //         0,
    //         0
    //     ]
    // );

    // const param = {
    //     routers: [process.env.SWAP_ROUTER],
    //     dexHandlerIds: [0],
    //     tokenIn: [process.env.TOKENA],
    //     data: [data] 
    // };

    // const desc = {
    //     tokenIn: process.env.TOKENA,
    //     tokenOut: process.env.TOKENB,
    //     amountIn: 10,
    //     minReturnAmount: 0,
    //     flags: 0
    // }

    // console.log("Ready to swap");

    // const tx3 = await agg.flexSwap(
    //     process.env.AGGREGATOR_EXECUTOR,
    //     param, 
    //     desc,
    //     { gasLimit: 2e7, gasPrice: 3e10 }
    // );
    // await tx3.wait();
    // console.log(tx3);
    // console.log("Swap Done");


}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});

