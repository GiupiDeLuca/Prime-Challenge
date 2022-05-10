// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./Pusd.sol";
import "./Prime.sol";

contract Vault is Ownable {

    Pusd internal pusd;
    Prime internal prime;

    constructor(Pusd _pusd, Prime _prime)  {
      pusd = _pusd;
      prime = _prime;
    }

    using SafeMath for uint256;

    struct Token {
        bytes32 ticker;
        address tokenAddress;
    }

    struct LockedDeposit {
        uint timeStamp;
        address client;
        bool withdrawn;
    }

    mapping(address => mapping(bytes32 => uint256)) public balances;

    mapping(bytes32 => Token) public tokenMapping;

    mapping (address => mapping(bytes32 => LockedDeposit)) public userDeposit;

    bytes32[] public tickers;

    modifier tokenExists(bytes32 ticker) {
        require(
            tokenMapping[ticker].tokenAddress != address(0),
            "token does not exist"
        );
        _;
    }

    function addToken(bytes32 ticker, address tokenAddr) external onlyOwner {
        require(
            tokenMapping[ticker].tokenAddress == address(0),
            "token already exists"
        );
        tokenMapping[ticker].tokenAddress = tokenAddr;
        tickers.push(ticker);
    }


    function deposit(uint256 _amount, bytes32 ticker)
        external
        tokenExists(ticker)
    {
        prime.transferFrom(msg.sender, address(this), _amount);
        balances[msg.sender][ticker] = balances[msg.sender][ticker].add(_amount);
    
        userDeposit[msg.sender][ticker].timeStamp = block.timestamp;
        userDeposit[msg.sender][ticker].client = msg.sender;
        userDeposit[msg.sender][ticker].withdrawn = false;
    }

    // set withdraw to true at some point
    function withdraw(bytes32 ticker)
        external
        tokenExists(ticker)
    {
        require(balances[msg.sender][ticker] > 0 , "cannot withdraw zero");
        require(userDeposit[msg.sender][ticker].timeStamp <= block.timestamp, "wrong timestamp");
        require(userDeposit[msg.sender][ticker].withdrawn == false, "already withdrawn");
        uint _timeDifference = block.timestamp.sub(userDeposit[msg.sender][ticker].timeStamp);
        require(_timeDifference >= 0, "cannot withdraw too soon"); // change to larger number later
        
        uint _balanceToWithdraw = balances[msg.sender][ticker];
        balances[msg.sender][ticker] = 0;

        uint _interestPerSecond = _balanceToWithdraw.div(3157760000);
        uint _interest = _interestPerSecond * _timeDifference;

        IERC20(tokenMapping[ticker].tokenAddress).transfer(msg.sender, _balanceToWithdraw);
        pusd.mint(msg.sender, _interest);
        userDeposit[msg.sender][ticker].withdrawn = true;
    }

}