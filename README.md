# Portalo

All-in-one solution to organize your life through private data storage 🪄📁

Portalo leverages blockchain technology to ensure you own your data while allowing you to safely share the data with anyone you want.

## Content 

This repository contains all the Smart Contracts and ZK circuits used by Portalo to ensure the privacy of the user data. 

### Circuits

- Ownership Circuit: Validates if a wallet is the owner of a Portalo profile.

### Smart Contracts

- Circuit Contract: Solidity Smart Contract as the Ownership circuit verifier.
- Portalo Contract: Main Portalo Smart Contract, that manages the profile's access and modifications. 

## How to

### Portalo Smart Contract

**Deploy**
- Deploy the Circuit Verifier Contrat before.
- Deploy the Portalo Smart Contract and initialize it with the Circuit Verifier Contract address.

### Noir ZK Circuit

**Installation**
- `Noir`: [Noir official guide](https://noir-lang.org/docs/getting_started/installation/)
- `bb`: https://github.com/AztecProtocol/aztec-packages/blob/master/barretenberg/cpp/src/barretenberg/bb/readme.md#installation

**Create new project**
```bash
nargo new <PROJECT_NAME>
cd <PROJECT_NAME>
nargo check
```

**Check the proof**
1. Put the inputs in `Prover.toml`
2. Generate the proof:
```bash
nargo execute
```

**Compile**
```bash
nargo compile
```

**Generate Solidity Verifier Smart Contract**
```bash
bb write_vk -b ./target/<noir_artifact_name>.json
bb contract
```