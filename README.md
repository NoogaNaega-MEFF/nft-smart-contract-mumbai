# NoogaNaega Red NFT smart contract on Polygon Mumbai test network.

This is a Solidity smart contract for a non-fungible token (NFT) collection named "NoogaNaega". 

"Minting" is like digital crafting; it's the process of creating new NFTs.

The contract limits how many NFTs you can mint at once up to 10 per transaction.

There's a feature to mint NFTs for free, but it can be turned on or off by the contract owner.

Pausing the Minting: The owner of the contract can pause the minting process. When paused, no one can create new NFTs.

Only the contract's owner can change certain settings, like pausing minting or changing the minting price. This helps prevent unauthorized changes to the contract.

The contract uses ReentrancyGuard to protect against certain types of cyber attacks.

Payments are split and distributed automatically to predetermined wallet addresses, ensuring additional security.

The owner can change how much it costs to create (mint) each NFT.

The contract allows the owner to set and update the base URL and file extension for the NFTs' metadata.

Metadata is like a digital certificate of authenticity for each NFT, providing details about it.

## Security analysis of our smart contract

1. Utilizes OpenZeppelin contracts for ERC721, Ownable, ReentrancyGuard, and PaymentSplitter, ensuring a robust and secure foundation.

2. Compatible with Solidity ^0.8.17, ensuring compatibility with versions within the 0.8.x range for security patches.

3. Transparent public variables for contract settings. Sensitive information like wallet addresses and allocations kept private.

4. Inherits from standard and trusted contracts (ERC721, Ownable, ReentrancyGuard, PaymentSplitter), providing a solid structure and preventing reentrancy attacks.

5. Comprehensive checks in publicMint and mintFreeNFT to ensure contract integrity during the minting process.

6. Owner-controlled pricing, requiring responsible management.

7. Administrative control maintained through owner-only functions for contract management.

8. No external calls to untrusted contracts, minimizing risks of unexpected behaviors.

Overall, the contract is well-written and secure, but it's still recommended to perform a thorough code review and testing to identify and mitigate any possible security threats.
