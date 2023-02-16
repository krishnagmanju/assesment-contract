const hre = require("hardhat");

async function main() {
  const InsuranceContractFact = await hre.ethers.getContractFactory(
    "InsuranceContract"
  );
  const InsuranceContract = await InsuranceContractFact.deploy();
  await InsuranceContract.deployed();
  console.log("Insurance Contract deployed to :", InsuranceContract.address);

}
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});