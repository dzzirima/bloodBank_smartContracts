const hre = require("hardhat");

async function main() {
  const BloodSample = await hre.ethers.getContractFactory("BloodBank");
  const bloodSample = await BloodSample.deploy();

  await bloodSample.deployed();

  //function to create a user
  const newUser = await bloodSample.createUser(
    "userid",
    "userrole",
    "useremail",
    "userfirstNAme",
    "userlastname",
    "O",
    66
  );
  const newUser2 = await bloodSample.createUser(
    "userid1",
    "userrole",
    "useremail",
    "userfirstNAme",
    "userlastname",
    "O+",
    66
  );

  //getting all users
  // const allUsers = await bloodSample.getAllUsers();

  //fetching  a particular user
  // const foundUser =  await bloodSample.getUser('userid1')

  /**donation related stuff */
  const newDonation = await bloodSample.createDonation(
    "userId2",
    "donationId",
    "donar name",
    "blood group o",
    12,
    "pending",
    "disease none",
    56
  );
  const newDonation2 = await bloodSample.createDonation(
    "userId2",
    "donationId2",
    "donar name",
    "blood group o",
    12,
    "pending",
    "disease none",
    56
  );

  //getting a particular donation
  // const donationFound = await bloodSample.getDonation('donationId2')

  //getting specific donations for the user

  // const userDonation = await bloodSample.getUserDonation("userId2");

  //getting the total number of things calling call
  // let totalDonations = await bloodSample.totalDonations.call();


  //function to change the the status of the donation
  let changeDonationStatus = await bloodSample.changeState("userid","userid1")
  const donationFound = await bloodSample.getDonation('donationId2')
  let totalDonations = await bloodSample.totalPendingDonations.call();

  console.log(changeDonationStatus)


///changing the status of donation

 

  console.log("Blood Sample deployed to:", bloodSample.address);


}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
