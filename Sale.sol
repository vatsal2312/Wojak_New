// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./IERC20.sol";
import "./Ownable.sol";
import "./SafeMath.sol";

contract Sale is Ownable  {
     
    using SafeMath for uint256;
    // The token we are selling
    IERC20 private token;

    // the price of token
    uint256 private TokenPerBNB;
    
    // the number of tokens already sold through this contract
    uint256 private tokensSold = 0;

    // How many distinct addresses have invested
    uint256 private investorCount = 0;
    
    // How much ETH each address has invested to this crowdsale
    mapping (address => uint256) private investedAmountOf;

    // A new investment was made
    event Invested(address investor, uint256 weiAmount, uint256 tokenAmount);
    
    // Calculated new price
    event RateChanged(uint256 oldValue, uint256 newValue);
    
    function initialize(address _token) public {
         token = IERC20(_token);
    }

    function investInternal(address receiver) private {
        require(receiver != address(0), "Zero Address");
        if(investedAmountOf[receiver] == 0) {
            // A new investor
            investorCount++;
        }

        // Update investor
        uint256 tokensAmount = (msg.value).mul(TokenPerBNB).div(10**10);
        investedAmountOf[receiver] += msg.value;
        // Update totals
        tokensSold += tokensAmount;

        // Emit an event that shows invested successfully
        emit Invested(receiver, msg.value, tokensAmount);
        
        // Transfer Token to owner's address
        token.transfer(receiver, tokensAmount);
       
        // Transfer Fund to owner's address
        payable(owner()).transfer(address(this).balance);
    }

    function invest() public payable {
        investInternal(msg.sender);
    }

    function setRate(uint256 value) onlyOwner public {
        require(value > 0);
        emit RateChanged(TokenPerBNB, value);
        TokenPerBNB = value;
    }
    
    function withdrawTokens(uint256 amount) onlyOwner public {
        require(token.balanceOf(address(this)) > amount , "Not enough tokens");
        token.transfer(owner(), amount);
    } 
    
    function getTokenPrice() public view returns (uint256){
        return TokenPerBNB;
    }
    
    function getTokenAddress() public view returns (IERC20){
        return token;
    }
}
