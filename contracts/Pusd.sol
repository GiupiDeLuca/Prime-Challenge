// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Pusd is ERC20, Ownable {

    // need to figure out the onlyOwner part

    // constructor(address _newOwner) ERC20("PUSD", "PUSD") {
    //     transferOwnership(_newOwner);
    // }

    constructor() ERC20("PUSD", "PUSD") {}

    function mint(address _to, uint _amount) public {
        _mint(_to, _amount);
    }

    function transferMint(address _newOwner) public {
        transferOwnership(_newOwner);
    }
}