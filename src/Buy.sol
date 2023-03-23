// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Purchase {
    AggregatorV3Interface internal priceFeed;
    IERC20 internal usdtToken;
    address payable public owner;

    constructor(address _priceFeedAddress, address _usdtTokenAddress){
        priceFeed = AggregatorV3Interface(_priceFeedAddress);
        usdtToken = IERC20(_usdtTokenAddress);
        owner = payable(msg.sender);
    }

    function purchaseAsset() public {
        (,int price,,,) = priceFeed.latestRoundData();
        uint256 amountToTransfer = uint256(price) * 1 ether / 10**8;
        require(usdtToken.transferFrom(msg.sender, owner, amountToTransfer), "Transfer failed");
        owner.transfer(3.5 ether);
    }
}