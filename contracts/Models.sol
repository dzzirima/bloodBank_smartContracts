//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

struct Donation{
      string donationId;
      
      string donation_id;
      string donar_name;
      uint256 donation_date;
      uint256 donation_executed_date;
      uint256 donation_amount;
      string donation_status;
      string disease;
      string[] steps;
      uint256 weight;

  
  
    }

struct User{
    string Id;
    bool verified;
    string role;
    string email;

    string firstname;
    string lastname;
    string bloodGroup;
    uint256 weight;
    uint256 joinDate;

    /*** List  of all users who has access to medical records */

}

struct Hostipal{
    string hospitalName;

}
