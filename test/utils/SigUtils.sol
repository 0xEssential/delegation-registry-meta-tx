pragma solidity ^0.8.17;

import {MinimalForwarder} from "openzeppelin-contracts/contracts/metatx/MinimalForwarder.sol";
import "openzeppelin-contracts/contracts/utils/cryptography/ECDSA.sol";

contract SigUtils {
    bytes32 internal DOMAIN_SEPARATOR;

    constructor(bytes32 _DOMAIN_SEPARATOR) {
        DOMAIN_SEPARATOR = _DOMAIN_SEPARATOR;
    }

    bytes32 private constant _TYPEHASH =
        keccak256("ForwardRequest(address from,address to,uint256 value,uint256 gas,uint256 nonce,bytes data)");

    // computes the hash of the fully encoded EIP-712 message for the domain, which can be used to recover the signer
    function getTypedDataHash(MinimalForwarder.ForwardRequest memory req) public view returns (bytes32) {
        return ECDSA.toTypedDataHash(
            DOMAIN_SEPARATOR,
            keccak256(abi.encode(_TYPEHASH, req.from, req.to, req.value, req.gas, req.nonce, keccak256(req.data)))
        );
    }
}
