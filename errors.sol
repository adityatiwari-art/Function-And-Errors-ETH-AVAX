
// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.17 and less than 0.9.0
pragma solidity ^0.8.26;

contract Errors {
    uint public stateVar=1;
    
    function _Require(address _add,uint _amount) public{
        require(_add==msg.sender,"Sorry! this address is not authorised for furthur process");
        require(_amount>100,"Insufficient balance");
        stateVar++;
    }
    
    function _Revert(address _add) public{
        stateVar++;
        if(_add!=msg.sender){
            revert("Unauthorised address");
        }

    }
    
    function _Assert(address _add) public payable{
        stateVar++;
        assert(_add==msg.sender);
    }

}
