# NoogaNaega Red NFT smart contract deployed on Polygon Mumbai test network.
Creation of Digital Collectibles (NFTs). The contract allows for the creation of up to 9,001 unique digital collectibles (NFTs). Each of these has a unique identifier and is stored on the blockchain.

# Key Features of the Contract are outlined below.
## Minting NFTs
"Minting" is like digital crafting; it's the process of creating new NFTs.
The contract limits how many NFTs you can mint at once to 10.
There's a feature to mint NFTs for free, but it can be turned on or off by the contract owner.
Pausing the Minting: The owner of the contract (like the admin) can pause the minting process. When paused, no one can create new NFTs.

## Ownership and Access Control
Only the contract's owner can change certain settings, like pausing minting or changing the minting price. 
This helps prevent unauthorized changes to the contract.

## Safety Measures
The contract uses something called ReentrancyGuard to protect against certain types of cyber attacks.
Payments are split and distributed automatically to predetermined wallet addresses, ensuring additional security.
The owner can change how much it costs to create (mint) each NFT.

## Digital Asset Information (Metadata)
The contract allows the owner to set and update the base URL and file extension for the NFTs' metadata.
Metadata is like a digital certificate of authenticity for each NFT, providing details about it.
