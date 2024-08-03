// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

import "@openzeppelin/contracts/utils/Strings.sol";

interface IVerifier {
    function verify(bytes calldata _proof, bytes32[] calldata _publicInputs) external view returns (bool);
}

contract Portalo {

    struct Profile {
        string profileId;
        string profileEncryptionKey;
        string encryptedData;
        bool isPublic;
    }

    struct SharedProfile {
        address recipient;
        string encryptedProfileEncryptionKey;
    }

    IVerifier verifier;

    mapping(address => string[]) public profileIdsByOwners;
    mapping(string => Profile) public profileByProfileId;
    mapping(string => mapping(address => string)) public profileSharedAccounts;

    constructor(address _verifierAddress) {
        verifier = IVerifier(_verifierAddress);
    }

    function saveProfile(Profile memory profile, bytes memory _proof, bytes32[] memory publicInput) external payable {
        // _verifyProof(_proof, publicInput);

        profileIdsByOwners[msg.sender].push(profile.profileId);
        profileByProfileId[profile.profileId] = profile;
    }

    // encryptedPEK -> profileEncryptionKey encrypted for that publicKey
    function grantAccess(address recipient, string memory profileId, string memory encryptedPEK,bytes memory _proof, bytes32[] memory publicInput) external payable {
        // _verifyProof(_proof, publicInput);

        profileSharedAccounts[profileId][recipient] = encryptedPEK;
    }

    function sharePublicProfile(Profile memory profile, bytes memory _proof, bytes32[] memory publicInput) external payable {
        // _verifyProof(_proof, publicInput);

        profileByProfileId[profile.profileId] = profile;
        profileByProfileId[profile.profileId].isPublic = true;

    }

    function revokeAccess(address recipient, string memory profileId, bytes memory _proof, bytes32[] memory publicInput) external payable {
        // _verifyProof(_proof, publicInput);

        delete profileSharedAccounts[profileId][recipient];
    }

    function resetEncryptionKey(Profile memory profile, bytes memory _proof, bytes32[] memory publicInput) external payable {
        // _verifyProof(_proof, publicInput);

        profileByProfileId[profile.profileId] = profile;
    }

  
    // function _verifyProof(bytes memory proof, bytes32[] memory publicInput) internal view {
    //     require(verifier.verify(proof, publicInput), "Invalid proof");
    // }
}