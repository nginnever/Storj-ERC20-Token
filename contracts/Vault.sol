pragma solidity ^0.4.8;

contract Vault {
    // vault addresses
    address public clientpool;
    address public vaultkey;
    address public recoverykey;
    // vault definitions
    uint public unvaultedAmount;
    uint public redeemblock;
    bool public destroyed;

    function unvault(uint amount) only_vaultkey {
        if (amount + unvaultedAmount > this.balance) return;
        unvaultedAmount += amount;
        redeemblock = block.timestamp + 24 hours;
        Unvault(amount);
    }

    function redeem() only_vaultkey {
        if (destroyed || block.timestamp < redeemblock) return;
        // TODO transfer tokens to correct address
        // the recover function should invalidate this request
        //clientpool.call.value(unvaultedAmount)();
        unvaultedAmount = 0;
        Redeem();
    }

    function recover(address newAccount) only_recoverykey {
        unvaultedAmount = 0;
        // TODO set client pool address to newAccount
        //clientpool = newAccount;
        Recover(newAccount);
    }
}