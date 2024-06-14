## UserInfo Smart Contract Project

This project includes a UserInfo smart contract that manages user information with registration and update functionalities. The contract is deployed using Hardhat.

Prerequisites

Node.js and npm installed
Git installed

## Setup Instructions

1. Clone the Repository
sh
Copy code
git clone https://github.com/your-username/your-repository.git
cd your-repository
2. Install Dependencies
sh
Copy code
npm install
3. Configure Environment Variables
Create a .env file in the project root with your private key:

plaintext
Copy code
PRIVATE_KEY=your_private_key_here
4. Hardhat Configuration
Update hardhat.config.js to use the private key from the .env file:

js
Copy code
require("@nomiclabs/hardhat-ethers");
require("@nomiclabs/hardhat-waffle");
require("dotenv").config();

module.exports = {
  defaultNetwork: "quorum",
  networks: {
    quorum: {
      url: "http://34.227.101.167:22000",
      accounts: [process.env.PRIVATE_KEY],
    },
  },
  solidity: "0.8.0",
};
Compile, Deploy, and Test

1. Compile the Smart Contract
sh
Copy code
npx hardhat compile
2. Deploy the Smart Contract
Create a deployment script scripts/deploy.js:

js
Copy code
async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address);

  const UserInfo = await ethers.getContractFactory("UserInfo");
  const userInfo = await UserInfo.deploy();
  await userInfo.deployed();

  console.log("UserInfo contract deployed to:", userInfo.address);
}

main().then(() => process.exit(0)).catch((error) => {
  console.error(error);
  process.exit(1);
});
Run the deployment script:

sh
Copy code
npx hardhat run scripts/deploy.js --network quorum

This project demonstrates how to manage user information using a smart contract, deploy it with Hardhat, and run tests to ensure its functionality. Follow the setup instructions to configure and deploy the UserInfo smart contract on your local or remote blockchain network.