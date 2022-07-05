pragma solidity ^0.8.0;
import "./Models.sol";

// import "hardhat/console.sol";

contract BloodBank{
        /**List of all users in the system */
    uint256 totalUsers;

    //mapping for users and their role

    mapping(string => User) public userIdMappings;
    mapping(string => Donation[]) Donations;
    mapping(string =>int ) BloodGroupDonations;
  
    User[] userArray;

    function createUser(
        string memory _userId,
        string memory _role,
        string memory _email,
        string memory _firstname,
        string memory _lastname
    ) public {
        // User storage  newUser = users[totalUsers];

        User memory newUser;
        
        newUser.Id = _userId;
        newUser.role = _role;
        newUser.email = _email;
        newUser.firstname = _firstname;
        newUser.lastname = _lastname;
        

        userIdMappings[_userId] = newUser;

        /**add that user to the list of their accesors */

        /**Add that user to an array */
        userArray.push(newUser);

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
        string memory _donation_id,
        string memory  _donar_name,
        string memory _donation_date,
        string memory bloodGroup,
        uint256 _donation_amount,
        string memory _donation_status,
        uint256 disease,
        string memory _weight,
        string memory steps
    ) public {
        Donation memory myDonation;

        myDonation.donationId = _donation_id;
        myDonation.donar_name = _donar_name;
        myDonation.donation_date = _donation_date;
        myDonation.donation_amount = _donation_amount;
        myDonation.donation_status = _donation_amount ;
        myDonation.status = _donation_status;
        myDonation.disease = disease;
        myDonation.steps = steps;

        console.log("New Donation was created in the blockchain");

        Donations[_donar_name].push(myDonation);

        //increase the donation quantity in the group
        BloodGroupDonations[bloodGroup] += BloodGroupDonations[bloodGroup] +_donation_amount;
    }


     function getDonation(string memory requestor)
        external
        view
        returns (Donations[] memory)
    {
        
        return Donations[requestor];
    }


    modifier onlyAdmninChangeState(string memory userId) {
        
        

        //make sure the owner is the sender
        // for(uint256 i = 0; i < userPrescriptions.length ; i++){

        //     require( (keccak256(bytes(userPrescriptions[i].owner)) == keccak256(bytes(accessorId))) ,"Your are not the owner");
        // }
        _;
    }

    modifier onlyAdmin(string memory userId){
        console.log("checking if the user is the admin....");
        require(userIdMappings[userId].role == 'admin');
        _;
    }



}