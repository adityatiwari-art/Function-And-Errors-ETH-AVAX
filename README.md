# SimpleBank

## Description

The SimpleBank contract allows users to deposit, withdraw, and transfer funds. It also includes an emergency withdrawal function restricted to the contract owner.

## Getting Started

### Executing Program

To run this program, you can use Remix, an online Solidity IDE. To get started, go to the Remix website at [Remix IDE](https://remix.ethereum.org).

### Create a New File

1. Click on the "+" icon in the left-hand sidebar.
2. Save the file with a .sol extension (e.g., SimpleBank.sol).

### Copy and Paste the Following Code

solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract SimpleBank {
    mapping(address => uint256) private balances;
    address public owner;

    constructor() payable {
        owner = msg.sender;
        balances[owner] = msg.value;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function.");
        _;
    }

    function deposit(uint _amount) public payable {
        require(_amount > 0, "Deposit amount must be greater than zero.");
        balances[msg.sender] += _amount;
        assert(balances[msg.sender] >= _amount);
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


### Compile the Code

1. Click on the "Solidity Compiler" tab in the left-hand sidebar.
2. Make sure the "Compiler" option is set to "0.8.26" (or another compatible version).
3. Click on the "Compile SimpleBank.sol" button.

### Deploy and Interact

1. Navigate to the "Deploy & Run Transactions" tab.
2. Deploy the contract and interact with it using the provided functions.

## Functions

### deposit(uint _amount)

- Allows users to deposit Ether into the contract.
- Ensures the deposit amount is greater than zero.
- Updates the user's balance.

### withdraw(uint256 _amount)

- Allows users to withdraw Ether from the contract.
- Ensures the withdrawal amount does not exceed the user's balance.
- Updates the user's balance and transfers the Ether.

### transfer(address _to, uint256 _amount)

- Allows users to transfer Ether to another address.
- Ensures the recipient address is valid and the user has sufficient balance.
- Updates the balances of both the sender and the recipient.

### emergencyWithdraw()

- Allows the contract owner to withdraw all Ether from the contract in case of an emergency.
- Ensures that the contract has no balance before allowing the withdrawal.

### getBalance(address _account)

- Returns the balance of a specified account.

## Authors

Aditya Tiwari

## License

This project is licensed under the MIT License - see the LICENSE.md file for details.
