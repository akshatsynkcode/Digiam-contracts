async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address);

  const balance = await deployer.getBalance();
  console.log("Account balance:", balance.toString());

  const UserInfo = await ethers.getContractFactory("UserInfo");
  const userInfo = await UserInfo.deploy();

  console.log("UserInfo contract deployed to:", userInfo.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
