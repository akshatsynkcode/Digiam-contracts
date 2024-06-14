const { expect } = require("chai");

describe("UserInfo", function () {
  let userInfo;
  let owner;
  let addr1;

  beforeEach(async function () {
    [owner, addr1] = await ethers.getSigners();
    const UserInfo = await ethers.getContractFactory("UserInfo");
    userInfo = await UserInfo.deploy();
    await userInfo.deployed();
  });

  it("Should add a new user", async function () {
    const tx = await userInfo.saveUser(1, "Alice", "alice@example.com");
    await tx.wait(); // Ensure the transaction is mined

    const user = await userInfo.getUser(1);

    expect(user[0]).to.equal("Alice");
    expect(user[1]).to.equal("alice@example.com");
    expect(user[2]).to.be.properAddress;
  });

  it("Should update an existing user", async function () {
    let tx = await userInfo.saveUser(1, "Alice", "alice@example.com");
    await tx.wait(); // Ensure the transaction is mined

    tx = await userInfo.saveUser(1, "Alice Updated", "alice_updated@example.com");
    await tx.wait(); // Ensure the transaction is mined

    const user = await userInfo.getUser(1);

    expect(user[0]).to.equal("Alice Updated");
    expect(user[1]).to.equal("alice_updated@example.com");
  });

  it("Should revert when getting a non-existent user", async function () {
    await expect(userInfo.getUser(1)).to.be.revertedWith("User does not exist");
  });
});
