// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract CertificateNFT is ERC721, Ownable {
    uint256 public nextTokenId;
    string private certificateURI;

    mapping(address => bool) public hasMinted;

    constructor(
        string memory _certificateURI
    ) ERC721("Blockchain & Web3 Certificate", "B3CERT") Ownable(msg.sender) {
        certificateURI = _certificateURI;
    }

    function mint() external {
        require(!hasMinted[msg.sender], "Certificate already minted");

        uint256 tokenId = nextTokenId;
        nextTokenId++;

        hasMinted[msg.sender] = true;
        _safeMint(msg.sender, tokenId);
    }

    function tokenURI(uint256) public view override returns (string memory) {
        return certificateURI;
    }
}
