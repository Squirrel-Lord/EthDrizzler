/**
 * This smart contract allows addresses to donate ether to a designated address.
 * The receiving address is changeable, but only the receiving address can
 * choose to accept donations.
*/

pragma solidity ^0.8.4;

contract Donator {
    address payable private receiverAddress;
    string public receiverName;
    uint public totalDonations;
    bool public donationsReceived;

    constructor() public {
        receiverAddress = payable(msg.sender);
        receiverName = "Contract Creator";
        totalDonations = 0;
        donationsReceived = false;
    }

    receive () external payable {}

    function setReceiver(address payable  _receiverAddress, string memory _receiverName) public {
        require(msg.sender == receiverAddress, "Error: You must be the current receiver to set the receiving address.");
        receiverAddress = _receiverAddress;
        receiverName = _receiverName;
    }
    
    function donate() public payable {
        payable(this).transfer(msg.value * 1000000000000000000);
        totalDonations += msg.value;
    }
    
    /**
     * This function lets the receiverAddress acquire the donations stored in the smart contract.
    */
    function receiveDonations() public payable {
        receiverAddress.transfer(totalDonations * 1000000000000000000);
    }
}