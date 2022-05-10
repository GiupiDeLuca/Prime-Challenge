const Pusd = artifacts.require("Pusd");
const Vault = artifacts.require("Vault");
const Prime = artifacts.require("Prime");

module.exports = async function (deployer, network, accounts) {
  await deployer.deploy(Prime);
  const prime = await Prime.deployed();
  await deployer.deploy(Pusd);
  const pusd = await Pusd.deployed();
  await deployer.deploy(Vault, pusd.address, prime.address);
  const vault = await Vault.deployed();
  // await pusd.transferMint(vault.address);

  // await prime.mint(accounts[1], 1000);
  // await prime.approve(vault.address, 1000, {from: accounts[1]});

  // const primeTicker = web3.utils.utf8ToHex("PRIME");

  // await vault.addToken(primeTicker, prime.address);

  // await vault.deposit(1000, primeTicker, {from: accounts[1]});

  // const balance = await vault.balances(accounts[1], primeTicker);
  // console.log("balance", balance.toNumber());
};

