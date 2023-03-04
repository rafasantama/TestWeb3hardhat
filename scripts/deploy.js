// deploy/deloy.js
require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-etherscan");
const hre = require("hardhat");


async function main() {
    const POAPtest = await hre.ethers.getContractFactory("POAPtest");
    const cTest = await POAPtest.deploy("abaacc");
    await cTest.deployed();
    console.log("Web3 Test Contract Deployed contract to:", cTest.address);
}

main().then(() => process.exit(0)).catch(error => {
    console.error(error);
    process.exit(1);
});
