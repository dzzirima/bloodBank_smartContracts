//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

struct Donation{
      string donationId;
      
      string donation_id;
      string donar_name;
      string donation_date;
      string donation_executed_date;
      string donation_amount;
      string donation_status;
      string disease;
      string[] steps;
  
  
    }

struct User{
    string Id;
    bool verified;
    string role;
    string email;

    string firstname;
    string lastname;
    string bloodGroup;
    string weight;
    string joinDate;

    /*** List  of all users who has access to medical records */

}

struct Hostipal{
    string hospitalName;

}
