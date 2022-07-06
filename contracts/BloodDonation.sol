pragma solidity ^0.8.0;
import "./Models.sol";

import "hardhat/console.sol";

contract BloodBank{
        /**List of all users in the system */
    uint256 public totalUsers;
    uint256 public totalDonations;
    uint256 public totalPendingDonations;

    //mapping for users and their role

    mapping(string => User) public userIdMappings;
    mapping(string => Donation)public Donations;
    mapping(string =>uint256 ) public BloodGroupDonations;
    mapping (string => Donation[]) public userDonations;
  
    User[] userArray;
    Donation[] DonationsArray;

    function createUser(
        string memory _userId,
        string memory _role,
        string memory _email,
        string memory _firstname,
        string memory _lastname,
        string memory bloodgroup,
        uint256 weight
    ) public {
        // User storage  newUser = users[totalUsers];

        User memory newUser;
        
        newUser.Id = _userId;
        newUser.role = _role;
        newUser.email = _email;
        newUser.firstname = _firstname;
        newUser.lastname = _lastname;
        newUser.joinDate = block.timestamp;
        newUser.bloodGroup = bloodgroup;
        newUser.weight = weight;
        

        userIdMappings[_userId] = newUser;

        /**add that user to the list of their accesors */

        /**Add that user to an array */
        userArray.push(newUser);

        totalUsers ++;

    }

    function getAllUsers() public view returns ( User[] memory) {
    return userArray;
    }
    //function to get the user
    function getUser(string memory userId)
        public
        view
        returns (User memory)
    {
        return userIdMappings[userId];
    }

    
    function removeUser(string memory userId) external {
        delete userIdMappings[userId]; // this  basically resets the index to default value
    }



    /**Donattion related function */
     function createDonation(
        string memory userId,
        string memory _donation_id,
        string memory  _donar_name,
       
        string memory bloodGroup,
        uint256 _donation_amount,
        string memory _donation_status,
        string memory disease,
        uint256  _weight
       
    ) public {
        Donation memory myDonation;

        myDonation.donationId = _donation_id;
        myDonation.donar_name = _donar_name;
        myDonation.donation_amount = _donation_amount;
        myDonation.donation_date = block.timestamp;
        myDonation.donation_status = "pending";
        myDonation.disease = disease;
        myDonation.weight =_weight;
       

        console.log("New Donation was created in the blockchain");

        //adding it to specific user array
        userDonations[userId].push(myDonation);

      //putting a donation in a map
      Donations[_donation_id] = myDonation;
        
        //adding the donation to list of other donation
        DonationsArray.push(myDonation);

        //increase the donation quantity in the group
        BloodGroupDonations[bloodGroup] += BloodGroupDonations[bloodGroup] +_donation_amount;
    
        totalDonations ++;
    }

     function getDonation(string memory donationId)
        public
        view
        returns (Donation memory)
    {
        
        return Donations[donationId];
    }


    function getUserDonation(string memory userId) public view returns(   Donation [] memory ){

        return userDonations[userId];

    }

    function changeState(string memory userId ,string memory donationId ) public onlyAdmninChangeState(userId) {
        Donation storage myDonation = Donations[donationId];

        myDonation.donation_status = "complete";

        totalPendingDonations  = totalDonations -1;
    }

    modifier onlyAdmninChangeState(string memory userId) {
        
        
        //make sure the owner is the sender
        // for(uint256 i = 0; i < userPrescriptions.length ; i++){

        //     require( (keccak256(bytes(userPrescriptions[i].owner)) == keccak256(bytes(accessorId))) ,"Your are not the owner");
        // }
        _;
    }

    modifier onlyAdmin(string memory userId){
        //fin
        User memory userFound  = userIdMappings[userId];

        require(keccak256(bytes(userFound.role)) == keccak256(bytes("admin")) , "only admins can complete the donation process");
        console.log("checking if the user is the admin....");
       
        // require(userIdMappings[userId].role == 'admin');
        _;
    }
}