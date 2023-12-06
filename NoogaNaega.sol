// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

// Importing necessary modules from OpenZeppelin
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import '@openzeppelin/contracts/finance/PaymentSplitter.sol';
import "@openzeppelin/contracts/utils/Counters.sol";

// Main contract declaration inheriting from ERC721, Ownable, ReentrancyGuard, and PaymentSplitter
contract NoogaNaega is ERC721, Ownable, ReentrancyGuard, PaymentSplitter {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    uint256 public maxSupply = 9001;  // Maximum number of NFTs that can be minted
    uint8 constant maxTokensPerTx = 10;  // Maximum number of NFTs that can be minted per transaction
    string public baseURI;  // Base URI for NFT metadata
    string public baseExtension = ".json";  // Extension of the NFT metadata files
    bool public paused = false;  // Flag to pause or unpause minting
    bool public isFreeMintActive = false; // Toggle for free minting feature
    uint256 _price = 10000000000000000; // Minting price (0.01 MATIC for testing)

    uint256[] private _walletAllocations = [50, 50];
    address[] private _wallets = [
        0x753B8f059cc9e0d5588524aAC078B01DC2327c68, 
        0xcf7103015F10455B9F0C85d44FeD5C10B01CF4C6
    ];

    // Mapping to track if an address has claimed a free NFT
    mapping(address => bool) public hasClaimedFreeNFT;

    // Constructor setting up ERC721 details and payment splitting
    constructor(string memory uri)
        ERC721("NoogaNaega", "N_N")
        PaymentSplitter(_wallets, _walletAllocations) 
    {
        setBaseURI(uri);
    }

    // Function to update the base URI
    function setBaseURI(string memory _tokenBaseURI) public onlyOwner {
        baseURI = _tokenBaseURI;
    }

    // Internal function to return the base URI
    function _baseURI() internal view override returns (string memory) {
        return baseURI;
    }

    // Function to toggle the paused state of the contract
    function togglePause() public onlyOwner {
        paused = !paused;
    }

    // Function to toggle the free minting feature
    function toggleFreeMint() public onlyOwner {
        isFreeMintActive = !isFreeMintActive;
    }

    // Function to allow public minting of NFTs
    function publicMint(uint256 amount) external payable {
        require(!paused, "Contract is paused");
        require(amount > 0 && amount <= maxTokensPerTx, "Minting amount should be between 1 and 10");
        require(_tokenIds.current() + amount <= maxSupply, "Max supply exceeded");
        require(_price * amount <= msg.value, "Insufficient funds");

        for (uint i = 0; i < amount; i++) {
            if (_tokenIds.current() < maxSupply) {
                _tokenIds.increment();
                uint256 tokenId = _tokenIds.current();
                _safeMint(msg.sender, tokenId);
            }
        }
    }

    // Function to mint a free NFT
    function mintFreeNFT() public {
        require(isFreeMintActive, "Free minting is not active.");
        require(!hasClaimedFreeNFT[msg.sender], "You have already claimed your free NFT.");
        require(_tokenIds.current() < maxSupply, "Max supply exceeded.");

        hasClaimedFreeNFT[msg.sender] = true;
        _tokenIds.increment();
        uint256 newTokenId = _tokenIds.current();
        _safeMint(msg.sender, newTokenId);
    }

    // Function to update the base extension for NFT metadata
    function setBaseExtension(string memory _newBaseExtension) public onlyOwner {
        baseExtension = _newBaseExtension;
    }

    // Function to return the total number of minted tokens
    function totalSupply() public view returns (uint) {
        return _tokenIds.current();
    }

    // Function to update the minting price
    function updateMintingPrice(uint256 newPrice) public onlyOwner {
        _price = newPrice;
    }
}