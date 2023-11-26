// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./FirstToken.sol";
import "./SecondToken.sol";

contract TokenExchange {
    FirstToken public first_token;
    SecondToken public second_token;
    uint256 private _exchange_rate;

    constructor(address _tokenFirst, address _tokenSecond) {
        first_token = FirstToken(_tokenFirst);
        second_token = SecondToken(_tokenSecond);
        _exchange_rate = 2;
    }

    event EventExchange(address user, uint256 first_amount, uint256 second_amount);

    modifier check_balance() {
        require(first_token.balanceOf(address(this)) > 0, "First balance is zero");
        require(second_token.balanceOf(address(this)) > 0, "Second balance is zero");
        _;
    }

    function FirstToSecond(uint256 _amount) external check_balance(){
        uint256 second_token_amount = _amount * _exchange_rate;
        require(first_token.balanceOf(msg.sender) >= _amount, "Insufficient balance");
        require(second_token.balanceOf(address(this)) >= second_token_amount, "Insufficient balance in exchange contract");

        emit EventExchange(msg.sender, _amount, second_token_amount);

        first_token.transferFrom(msg.sender, address(this), _amount);
        second_token.transfer(msg.sender, second_token_amount);
    }

    function SecondToFirst(uint256 _amount) external check_balance(){
        uint256 first_token_amount = _amount / _exchange_rate;
        require(second_token.balanceOf(msg.sender) >= _amount, "Insufficient balance");
        require(first_token.balanceOf(address(this)) >= first_token_amount, "Insufficient balance in exchange contract");

        emit EventExchange(msg.sender, _amount, first_token_amount);

        second_token.transferFrom(msg.sender, address(this), _amount);
        first_token.transfer(msg.sender, first_token_amount);
    }
}
