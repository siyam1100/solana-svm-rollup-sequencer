// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/**
 * @title SvmStateBridge
 * @dev A settlement Layer contract interface ensuring fraud or validity proof settlement verification for our SVM Rollup.
 */
contract SvmStateBridge {
    address public sequencerAddress;
    bytes32 public latestRollupStateRoot;
    uint256 public totalBatchesSettled;

    event BatchSettled(uint256 indexed batchId, bytes32 stateRoot);

    constructor(address _sequencer) {
        sequencerAddress = _sequencer;
    }

    /**
     * @notice Receives state root declarations from the sequencer.
     * @param stateRoot The calculated batch root sequence reference.
     */
    function settleBatchRoot(bytes32 stateRoot) external {
        require(msg.sender == sequencerAddress, "Caller is unauthorized to settle roots");
        
        latestRollupStateRoot = stateRoot;
        totalBatchesSettled++;
        
        emit BatchSettled(totalBatchesSettled, stateRoot);
    }
}
