const { assert, expect } = require("chai");

const Prime = artifacts.require("Prime");

contract("Prime", async (accounts) => {
  let prime;

  beforeEach(async () => {
    prime = await Prime.deployed();
  });

  it("Should mint 1000 PRIME tokens for a user", async () => {
    await prime.mint(accounts[2], 1000);

    const totalSupply = await prime.totalSupply();
    const balance1 = await prime.balanceOf(accounts[2]);

    // asserts that the total supply is, at this point, 1000
    assert(totalSupply.toNumber() == 1000);
    
    // expects balance of accounts[2] to be 1000
    expect(balance1.toNumber()).to.equal(1000);
  });
});
