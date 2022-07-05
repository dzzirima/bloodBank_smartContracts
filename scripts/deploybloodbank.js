
const hre = require("hardhat");

async function main() {
 
  const BloodSample = await hre.ethers.getContractFactory("bloodunitconsumption");
  const bloodSample = await BloodSample.deploy("Hello, Hardhat!");

  await bloodSample.deployed();

  console.log("Blood Sample deployed to:", bloodSample.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
