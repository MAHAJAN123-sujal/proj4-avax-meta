Here’s a README tailored for the `DeGame` smart contract, assuming it is purely built using Remix IDE:

---

## DeGame Token

The `DeGame` contract is an ERC20 token deployed on the blockchain, designed for a gaming ecosystem. It allows users to earn tokens, redeem them for in-game items, and manage their inventory.

### Contract Details

The `DeGame` smart contract extends the ERC20 standard and adds functionalities for managing in-game items, token minting, burning, and redeeming.

#### State Variables

- `string private constant tokenName`: The name of the token.
- `string private constant Symbol`: The symbol of the token.
- `uint itemCount`: Counter for the total number of items.
- `mapping (uint => item) items`: Stores items available for redemption.
- `mapping (address => item[]) redeemedItem`: Maps user addresses to their redeemed items.
- `address public owner`: The address of the contract owner.

#### Structs

- `struct item`: Represents an in-game item.
  - `uint id`: Unique identifier for the item.
  - `string itemName`: Name of the item.
  - `uint price`: Price of the item in tokens.

#### Constructor

```solidity
constructor() ERC20(tokenName, Symbol) {
    owner = msg.sender;
}
```

Initializes the token with a name and symbol and sets the deployer as the owner.

#### Functions

##### name

```solidity
function name() public view virtual override returns (string memory) {
    return tokenName;
}
```

Returns the name of the token.

##### symbol

```solidity
function symbol() public view virtual override returns (string memory) {
    return Symbol;
}
```

Returns the symbol of the token.

##### decimals

```solidity
function decimals() public view virtual override returns (uint8) {
    return 0;
}
```

Returns the number of decimals used by the token (set to 0).

##### balanceOf

```solidity
function balanceOf(address account) public view override returns (uint) {
    return super.balanceOf(account);
}
```

Returns the token balance of the specified address.

##### mint

```solidity
function mint(address to, uint256 amount) public onlyOwner {
    _mint(to, amount);
}
```

Allows the contract owner to mint new tokens and distribute them to specified addresses.

##### burn

```solidity
function burn(uint256 amount) public {
    _burn(msg.sender, amount);
}
```

Allows any token holder to burn a specified amount of their tokens.

##### transfer

```solidity
function transfer(address to, uint256 amount) public virtual override returns (bool) {
    _transfer(msg.sender, to, amount);
    return true;
}
```

Allows token holders to transfer tokens to other addresses.

##### listNewItem

```solidity
function listNewItem(string memory itemName, uint price) public onlyOwner {
    itemCount++;
    items[itemCount] = item(itemCount, itemName, price);
}
```

Allows the contract owner to list new items with a name and price.

##### displayAllItems

```solidity
function displayAllItems() public view returns (item[] memory) {
    item[] memory temp = new item[](itemCount);
    for (uint i = 1; i <= itemCount; i++) {
        temp[i - 1] = items[i];
    }
    return temp;
}
```

Returns an array of all listed items.

##### redeem

```solidity
function redeem(uint id) public {
    require(id <= itemCount, "Item doesn't exist");
    require(items[id].price <= balanceOf(msg.sender), "You don't have enough tokens.");
    _transfer(msg.sender, owner, items[id].price);
    redeemedItem[msg.sender].push(items[id]);
}
```

Allows users to redeem tokens for in-game items. The specified item ID must exist and the user must have enough tokens.

##### redeemedItems

```solidity
function redeemedItems() public view returns(item[] memory) {
    return redeemedItem[msg.sender];
}
```

Returns the list of items redeemed by the caller.

### Deployment

To deploy the `DeGame` contract using Remix IDE:

1. **Open Remix IDE**:
   - Navigate to [Remix IDE](https://remix.ethereum.org/).

2. **Create a New File**:
   - Create a new file in the `contracts` directory named `DeGame.sol`.

3. **Paste Contract Code**:
   - Copy and paste the `DeGame` contract code into the new file.

4. **Compile the Contract**:
   - Go to the "Solidity Compiler" tab and compile the `DeGame.sol` file.

5. **Deploy the Contract**:
   - Go to the "Deploy & Run Transactions" tab.
   - Select the desired environment (e.g., JavaScript VM, Injected Web3).
   - Click "Deploy" to deploy the contract.

### Interacting with the Contract

Once deployed, you can interact with the `DeGame` contract directly from Remix IDE:

- **Mint Tokens**:
  - Use the `mint` function to mint new tokens to a specified address.

- **Burn Tokens**:
  - Use the `burn` function to burn a specified amount of tokens from your account.

- **Transfer Tokens**:
  - Use the `transfer` function to transfer tokens to another address.

- **List New Item**:
  - Use the `listNewItem` function to list new in-game items.

- **Display All Items**:
  - Use the `displayAllItems` function to view all listed items.

- **Redeem Items**:
  - Use the `redeem` function to redeem tokens for an item using its ID.

- **View Redeemed Items**:
  - Use the `redeemedItems` function to view items redeemed by your account.

### License

This project is licensed under the MIT License - see the LICENSE file for details.

### Authors

Sujal Mahajan

### Contributing

Contributions are welcome! Feel free to submit issues and pull requests.

---

This README provides a comprehensive guide to understanding, deploying, and interacting with the `DeGame` smart contract using Remix IDE.
