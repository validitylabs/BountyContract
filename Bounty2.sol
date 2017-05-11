pragma solidity ^0.4.8;

contract Bounty2 {
    mapping(bytes32 => bool) public validCode;
    
    address public owner;
    uint public myBalance;
    uint public numBeneficiaries;
    
    function Bounty2(uint _numBeneficiaries) {
        owner = msg.sender;
        numBeneficiaries = _numBeneficiaries;
    }
    
    function () payable {
        myBalance += msg.value;
    }
    
    modifier onlyOwner() {
        if (msg.sender != owner)
            throw;
        _;
    }
    
    function addCode(bytes32 code) onlyOwner {
        validCode[code] = true;
    }
    
    function codeValid(string plaintextCode) constant returns (bool) {
        return validCode[sha3(plaintextCode)];
    }
    
    function requestPayout(string plaintextCode) {
        if (validCode[sha3(plaintextCode)])
            msg.sender.send(myBalance / numBeneficiaries);
        else
            throw;
        validCode[sha3(plaintextCode)] = false;
    }
}
