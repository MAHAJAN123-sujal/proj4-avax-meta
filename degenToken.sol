// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract DeGame is ERC20 {
    
    string private constant tokenName = "Degen";
    string private constant Symbol = "DGN";

    struct item{
        uint id;
        string itemName;
        uint price;
    }

    uint itemCount = 0;
    mapping (uint => item) items;
    mapping (address => item[]) redeemedItem;
    address public owner;

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }
    constructor() ERC20(tokenName, Symbol) {
        owner = msg.sender;
    }

    function name() public view virtual override  returns (string memory) {
        return tokenName;
    }

    function symbol() public view virtual override returns (string memory) {
        return Symbol;
    }

    function decimals() public view virtual override returns (uint8){
        return 0;
    }

    function balanceOf(address account) public view override returns(uint){
        return super.balanceOf(account);
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function burn(uint256 amount) public {
        _burn(msg.sender, amount);
    }

    function transfer(address to, uint256 amount) public virtual override returns (bool) {
        _transfer(msg.sender, to, amount);
        return true;
    }

    function listItem (string memory itemName, uint price) public onlyOwner{
        itemCount ++ ;
        items[itemCount] = item(itemCount, itemName, price);
    }

    function displayItems() public view returns (item[] memory) {
        item[] memory temp = new item[](itemCount);
        for (uint i = 1; i <= itemCount; i++) {
            temp[i - 1] = items[i];
        }
        return temp;
    }

    function redeem (uint id) public {
        require(id<=itemCount, "item doesn't exist");
        require(items[id].price <= balanceOf(msg.sender), "You don't have enough tokens.");
        _transfer(msg.sender,owner, items[id].price);
        redeemedItem[msg.sender].push(items[id]);
    }

    function showRedeemedItem() public view returns(item[] memory){
        return redeemedItem[msg.sender];
    }
}
