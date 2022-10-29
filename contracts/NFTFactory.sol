// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./NFTContract.sol";
import "./interface/INFTContract.sol";
import "./NFTContract.sol";

contract NFTFactory is Ownable { 
  using SafeMath for uint256;

    mapping (address=>uint256[]) ownerAddressForNFTProjects;
    mapping (uint256 =>address) projectIdForNFTProject;

    uint256 lastProjectId;

    // IFeeValult private feeVault;
    // constructor (IFeeValult _feeVault) {    
    // feeVault = _feeVault;
    // }


    function createProject(string memory _name, string memory _symbol) external {

    NFTContract newContract = new NFTContract();
    newContract.initialize(_name,_symbol);

    lastProjectId = lastProjectId.add(1);
    projectIdForNFTProject[lastProjectId] = address(newContract);

    uint256 sendersProjectsAmount = ownerAddressForNFTProjects[msg.sender].length;
    ownerAddressForNFTProjects[msg.sender][sendersProjectsAmount.add(1)] = lastProjectId;
    }



}


