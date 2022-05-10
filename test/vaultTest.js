const { assert, expect } = require("chai");

const Prime = artifacts.require("Prime");
const Vault = artifacts.require("Vault");
const Pusd = artifacts.require("Pusd");

contract("Vault", async (accounts) => {
  let prime;
  let vault;
  let pusd;

  beforeEach(async () => {
    prime = await Prime.deployed();
    pusd = await Pusd.deployed();
    vault = await Vault.deployed(pusd.address, prime.address);
  });

  it("Should allow the user to earn PUSD interest by depositing PRIME", async () => {
    // mint PRIME to accounts[1]
    await prime.mint(accounts[1], 1000);
    const balance1 = await prime.balanceOf(accounts[1]);
    console.log("balance1", balance1.toNumber());

    // deposit 1000 PRIME to vault
    prime.approve(vault.address, 1000, {from: accounts[1]});
    const primeTicker = await web3.utils.utf8ToHex("PRIME")
    vault.addToken(primeTicker, prime.address);
    vault.deposit(1000, primeTicker, {from: accounts[1]});


    // assert balance of accounts[1] is indeed 1000
    const balance2 = await vault.balances(accounts[1], primeTicker);
    console.log("balance2", balance2.toNumber());

    // withdraw 1000 PRIME from vault
    // await vault.withdraw(primeTicker, { from: accounts[1] });

    // assert pusd.balanceOf() user is > 0;
    // const pusdBalance = await pusd.balanceOf(accounts[1]);
    // console.log("pusdBalance", pusdBalance);
  });
});
