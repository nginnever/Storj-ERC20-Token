pragma solidity ^0.4.4;

import "./Token.sol";

/// @title SJCX Allocation - Time-locked vault of tokens allocated
/// to client pool
contract SJCXAllocation {
    // Total number of allocations to distribute additional tokens among
    // clients. The clients have right to X allocations
    uint256 constant totalAllocations = 5000000000;

    // Addresses of client and Storj Labs to allocations mapping.
    mapping (address => uint256) allocations;

    Voxelots vox;
    uint256 unlockedAt;

    uint256 tokensCreated = 0;

    function SJCXAllocation(address _storj) internal {
        vox = Voxelots(msg.sender);
        unlockedAt = now + 6 * 30 days;

        // For Storj Reserves:
        allocations[_storj] = 20000; // TODO get storj allocation.

        // For Client holdings pool:
        allocations[0x9d3F257827B17161a098d380822fa2614FF540c8] = 2500; // 25.0% of developers' allocations (10000).
        allocations[0xd7406E50b73972Fa4aa533a881af68B623Ba3F66] =  730; //  7.3% of developers' allocations.
    }

    /// @notice Allow developer to unlock allocated tokens by transferring them
    /// from SJCXAllocation to developer's address.
    function unlock() external {
        if (now < unlockedAt) throw;

        // During first unlock attempt fetch total number of locked tokens.
        if (tokensCreated == 0)
            tokensCreated = vox.balanceOf(this);

        var allocation = allocations[msg.sender];
        allocations[msg.sender] = 0;
        var toTransfer = tokensCreated * allocation / totalAllocations;

        // Will fail if allocation (and therefore toTransfer) is 0.
        if (!gnt.transfer(msg.sender, toTransfer)) throw;
    }
}
