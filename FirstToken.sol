// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract FirstToken is ERC20 {
    address private _owner;
    uint256 private _total;

    constructor() ERC20("First token", "FIRST") {
        _total = 100000000*(10**18);
        _owner = msg.sender;
        _mint(address(this), _total/1000*50);
        _mint(_owner, _total/10000*50);
    }
}
