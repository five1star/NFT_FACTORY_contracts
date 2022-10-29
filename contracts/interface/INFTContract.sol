// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

interface INFTContract is IERC721 { 


    function initialize(string memory _overrideName, string memory _overrideSymbol) external;

    function mint() external;

    function tokenURI(uint256 tokenId) external view returns (string memory) ;

    function setBaseURI(string memory _newBaseURI)  external;
}