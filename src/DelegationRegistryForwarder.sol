pragma solidity ^0.8.15;

import {MinimalForwarder} from "openzeppelin-contracts/contracts/metatx/MinimalForwarder.sol";

contract DelegationRegistryForwarder is MinimalForwarder {
    function domainSeparator() external view returns (bytes32) {
        return _domainSeparatorV4();
    }
}
