// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract SimpleBank {
    mapping(address => uint256) private balances;
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function.");
        _;
    }

    function deposit() public payable {
        require(msg.value > 0, "Deposit amount must be greater than zero.");
        balances[msg.sender] += msg.value;
        assert(balances[msg.sender] >= msg.value);
    }

    function withdraw(uint256 _amount) public {
        require(_amount <= balances[msg.sender], "Insufficient balance.");
        balances[msg.sender] -= _amount;
        payable(msg.sender).transfer(_amount);
        assert(balances[msg.sender] >= 0);
    }

    function transfer(address _to, uint256 _amount) public {
        require(_to != address(0), "Invalid recipient address.");
        require(_amount <= balances[msg.sender], "Insufficient balance.");
        balances[msg.sender] -= _amount;
        balances[_to] += _amount;
        assert(balances[_to] >= _amount);
    }

    function emergencyWithdraw() public onlyOwner {
        if (address(this).balance > 0) {
            revert("Emergency withdrawal is not allowed when contract has balance.");
        }
        payable(owner).transfer(address(this).balance);
    }

    function getBalance(address _account) public view returns (uint256) {
        return balances[_account];
    }
}

