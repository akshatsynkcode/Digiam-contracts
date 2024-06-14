require("@nomiclabs/hardhat-ethers");
require("@nomiclabs/hardhat-waffle");
require("dotenv").config(); // Import the dotenv package

console.log("Private Key:", process.env.PRIVATE_KEY); // Add this line to verify

module.exports = {
  defaultNetwork: "quorum",
  networks: {
    quorum: {
      url: "http://34.227.101.167:22000",
      accounts: process.env.PRIVATE_KEY ? [process.env.PRIVATE_KEY] : [],  // Use the private key from environment variables
    }
  },
  solidity: {
    version: "0.8.0",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200
      }
    }
  }
};
