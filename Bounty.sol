pragma solidity ^0.4.8;

contract Bounty {
    uint public myBalance;
    uint public numBeneficiaries;
    
    mapping(address => bool) public receivedPayment;
    
    function Bounty(uint _numBeneficiaries) {
        numBeneficiaries = _numBeneficiaries;
    }
    
    function addBalance() payable {
        myBalance += msg.value;
    }
    
    function () {
        if (receivedPayment[msg.sender])
            throw;
        receivedPayment[msg.sender] = true;
        msg.sender.transfer(myBalance / numBeneficiaries);
    }
}
