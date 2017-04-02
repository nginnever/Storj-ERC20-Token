# storjcoin-erc20-token
An ethereum standard token for Storjcoin

## Table of Contents

- [Token Contract Information](#token-contract-information)
- [How To Watch The Token Contract In Ethereum Wallet / Mist](#how-it-works)
- [How To Watch The Token In Ethereum Wallet / Mist](#)
- [The Token Contract Source Code](#)


### Token Contract Information

- Symbol: `SRJ` // To be determined
- Name: Storjcoin
- Address: Coming Soon
- Decimal places: 8 // Aligns with bitcoin not the 18 in ethereum
- Total supply: 500,000,000

### The Token Contract Source Code

```javascript
pragma solidity ^0.4.2;

// ERC Token Standard #20
// https://github.com/ethereum/EIPs/issues/20

contract ERC20Interface {

    // Get the total token supply
    // Signature 18160ddd totalSupply()
    function totalSupply() constant returns (uint256 totalSupply);
    
    // Get the account balance of another account with address _owner
    // Signature 70a08231 balanceOf(address)
    function balanceOf(address _owner) constant returns (uint256 balance);
    
    // Send _value amount of tokens to address _to
    // Signature a9059cbb transfer(address,uint256)
    function transfer(address _to, uint256 _value) returns (bool success);
    
    // Send _value amount of tokens from address _from to address _to
    // The transferFrom method is used for a withdraw workflow, allowing contracts to send 
    // tokens on your behalf, for example to "deposit" to a contract address and/or to charge 
    // fees in sub-currencies; the command should fail unless the _from account has 
    // deliberately authorized the sender of the message via some mechanism; we propose 
    // these standardized APIs for approval:
    // Signature 23b872dd transferFrom(address,address,uint256)
    function transferFrom(address _from, address _to, uint256 _value) returns (bool success);
    
    // Allow _spender to withdraw from your account, multiple times, up to the _value amount. 
    // If this function is called again it overwrites the current allowance with _value.
    // Signature 095ea7b3 approve(address,uint256)
    function approve(address _spender, uint256 _value) returns (bool success);
    
    // Returns the amount which _spender is still allowed to withdraw from _owner
    // Signature dd62ed3e allowance(address,address)
    function allowance(address _owner, address _spender) constant returns (uint256 remaining);
    
    // Triggered when tokens are transferred.
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    
    // Triggered whenever approve(address _spender, uint256 _value) is called.
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
}
```
