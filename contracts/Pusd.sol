// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Pusd is ERC20, Ownable {

    constructor() ERC20("PUSD", "PUSD") {}

    function mint(address _to, uint _amount) public {
        _mint(_to, _amount);
    }

    function transferMintRights(address _newOwner) public {
        transferOwnership(_newOwner);
    }
}