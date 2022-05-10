// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC20/presets/ERC20PresetMinterPauser.sol";

contract Prime is ERC20PresetMinterPauser {
    constructor() ERC20PresetMinterPauser("PRIME", "PRM") {}
}