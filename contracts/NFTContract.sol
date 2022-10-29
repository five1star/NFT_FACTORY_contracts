// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Strings.sol"; 
import "./interface/INFTContract.sol";

contract NFTContract is ERC721("BULK", "BLK"), Ownable { 

    string private _name;
    string private _symbol;
    string private baseURI;
    string private baseExtension = ".json";
    bool private isInitialized = false;
    uint8 public maximumPublishAmount = 20;

    modifier checkInitialized {
        require(isInitialized, "NFTContract: is not Initialized Yet!");
        _;
    }

    function initialize(string memory _overrideName, string memory _overrideSymbol) public onlyOwner {
    _name = _overrideName;
    _symbol = _overrideSymbol;

    isInitialized = true;
    }

    function name() public view override checkInitialized returns(string memory){
        return _name;
    }

    function symbol() public view override checkInitialized returns(string memory){
        return _symbol;
    }

    function mint() public{
        _safeMint(msg.sender,1);
    }


    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        _requireMinted(tokenId);
        require(tokenId <= maximumPublishAmount, "NFTContract: Invalid TokenId!");
        return string(abi.encodePacked(_baseURI(),"/", Strings.toString(tokenId), baseExtension));
    }

    function _baseURI() internal view override checkInitialized returns (string memory) {
        return baseURI;
    }

    function setBaseURI(string memory _newBaseURI) checkInitialized external onlyOwner{
        baseURI = _newBaseURI;
    }
}