pragma solidity ^0.4.8;


import './ERC20.sol';
import './SafeMath.sol';


/**
 * Standard ERC20 token
 *
 * https://github.com/ethereum/EIPs/issues/20
 * Based on code by FirstBlood:
 * https://github.com/Firstbloodio/token/blob/master/smart_contract/FirstBloodToken.sol
 */

/// @title Storj Token (STORJ) - token code for Storj Labs

contract StorjToken is ERC20, SafeMath {

  mapping(address => uint) balances;
  mapping (address => mapping (address => uint)) allowed;

  string public name;
  string public symbol;
  uint public totalSupply;
  uint8 public decimals;

  function StorjToken(string _name,
                      string _symbol,
                      uint _totalSupply,
                      uint8 _decimalUnits,
                      address _migrationMaster
    ) {
    balances[_migrationMaster] = _totalSupply; // Allocate all tokens initially to multisig account 
    name = _name;
    symbol = _symbol;
    totalSupply = _totalSupply;
    decimals = _decimalUnits;
  }


  function transfer(address _to, uint _value) returns (bool success) {
    balances[msg.sender] = safeSub(balances[msg.sender], _value);
    balances[_to] = safeAdd(balances[_to], _value);
    Transfer(msg.sender, _to, _value);
    return true;
  }

  function transferFrom(address _from, address _to, uint _value) returns (bool success) {
    var _allowance = allowed[_from][msg.sender];

    // Check is not needed because safeSub(_allowance, _value) will already throw if this condition is not met
    // if (_value > _allowance) throw;

    balances[_to] = safeAdd(balances[_to], _value);
    balances[_from] = safeSub(balances[_from], _value);
    allowed[_from][msg.sender] = safeSub(_allowance, _value);
    Transfer(_from, _to, _value);
    return true;
  }

  function balanceOf(address _owner) constant returns (uint balance) {
    return balances[_owner];
  }

  function approve(address _spender, uint _value) returns (bool success) {
    allowed[msg.sender][_spender] = _value;
    Approval(msg.sender, _spender, _value);
    return true;
  }

  function allowance(address _owner, address _spender) constant returns (uint remaining) {
    return allowed[_owner][_spender];
  }

  function burn() {
    // TODO
    // https://github.com/miohtama/Edgeless-Smart-Contracts/blob/master/original_contracts/original_token.sol#L102
  }
}
