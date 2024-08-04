// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

interface IVerifier {
    function verify(bytes calldata _proof, bytes32[] calldata _publicInputs) external view returns (bool);
}

contract Portalo {

    struct Profile {
        string profileId;
        string nonce;
        string profileEncryptionKey;
        string encryptedData;
        bool isPublic;
    }

    IVerifier verifier;

    mapping(address => string[]) public profileIdsByOwners;
    mapping(string => Profile) public profileByProfileId;

    constructor(address _verifierAddress) {
        verifier = IVerifier(_verifierAddress);
    }

    function saveProfile(Profile memory profile, bytes memory _proof, bytes32[] memory publicInput, bool isEditing) external {
        _verifyProof(_proof, publicInput);

        if (!isEditing) {
            // ToDo: Encrypt this array
            profileIdsByOwners[msg.sender].push(profile.profileId);
        }

        profileByProfileId[profile.profileId] = profile;
    }
  
    function _verifyProof(bytes memory proof, bytes32[] memory publicInput) internal view {
        require(verifier.verify(proof, publicInput), "Invalid proof");
    }

    function getProfileIdsByOwner() external view returns (string[] memory) {
        return profileIdsByOwners[msg.sender];
    }

    function getProfileById(string memory profileId) external view returns (Profile memory) {
        return profileByProfileId[profileId];
    }
}