use dep::std::ecdsa_secp256k1::verify_signature;

fn main(
  hashed_signature: [u8; 32],
  profileId: pub [u8; 8],
  nonce: pub [u8; 8], 
  hashed_encryption_key: pub [u8; 32]
) {
    let secret: [u8; 48] = hashed_signature.as_slice().append(profileId.as_slice()).append(nonce.as_slice()).as_array();

    let hashed_secret = std::hash::sha256(secret);
    assert(hashed_secret == hashed_encryption_key);
}

#[test]
fn test_main() {
    let signature = std::hash::sha256("0x1f5947fca12d9ab31bd573c83d40ce5e5d89f3d99e32ab5f4daccd0940aa5f114ec1917552ba1f66456bf6d0066ac0d6cd5b926bf6e1a16433eac77d1dead43a1b".as_bytes()); 
    let profile_id: [u8; 8] = "12345678".as_bytes();
    let nonce: [u8; 8] = "12345678".as_bytes();

    let signature_as_slice = signature.as_slice();
    let profile_id_as_slice = profile_id.as_slice();
    let nonce_as_slice = nonce.as_slice();

    let secret:[u8; 48] = signature_as_slice.append(profile_id_as_slice).append(nonce_as_slice).as_array();

    let hashed_encryption_key = std::hash::sha256(secret);

    main(signature, profile_id, nonce, hashed_encryption_key);
}