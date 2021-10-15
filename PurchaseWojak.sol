/**
 *Submitted for verification at BscScan.com on 2021-10-11
*/

// SPDX-License-Identifier: ISC

pragma solidity ^0.8.7;


interface IBEP20 {
    /**
     * @dev returns the name of the token
     */
    function name() external view returns (string memory);

    /**
     * @dev returns the symbol of the token
     */
    function symbol() external view returns (string memory);

    /**
     * @dev returns the decimal places of a token
     */
    function decimals() external view returns (uint8);

    /**
     * @dev returns the total tokens in existence
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev returns the tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev transfers the `amount` of tokens from caller's account
     * to the `recipient` account.
     *
     * returns boolean value indicating the operation status.
     *
     * Emits a {Transfer} event
     */
    function transfer(address recipient, uint256 amount)
        external
        returns (bool);

    /**
     * @dev returns the remaining number of tokens the `spender' can spend
     * on behalf of the owner.
     *
     * This value changes when {approve} or {transferFrom} is executed.
     */
    function allowance(address owner, address spender)
        external
        view
        returns (uint256);

    /**
     * @dev sets `amount` as the `allowance` of the `spender`.
     *
     * returns a boolean value indicating the operation status.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev transfers the `amount` on behalf of `spender` to the `recipient` account.
     *
     * returns a boolean indicating the operation status.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(
        address spender,
        address recipient,
        uint256 amount
    ) external returns (bool);

    /**
     * @dev Emitted from tokens are moved from one account('from') to another account ('to)
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when allowance of a `spender` is set by the `owner`
     */
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
}
 

/*
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
abstract contract Context {
    function msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }
     function _msgValue() internal view virtual returns (uint256) {
        return msg.value;
    }
} 

/**
 * @dev Contract module that helps prevent reentrant calls to a function.
 *
 * Inheriting from `ReentrancyGuard` will make the {nonReentrant} modifier
 * available, which can be applied to functions to make sure there are no nested
 * (reentrant) calls to them.
 *
 * Note that because there is a single `nonReentrant` guard, functions marked as
 * `nonReentrant` may not call one another. This can be worked around by making
 * those functions `private`, and then adding `external` `nonReentrant` entry
 * points to them.
 *
 * TIP: If you would like to learn more about reentrancy and alternative ways
 * to protect against it, check out our blog post
 * https://blog.openzeppelin.com/reentrancy-after-istanbul/[Reentrancy After Istanbul].
 */
abstract contract ReentrancyGuard {
    // Booleans are more expensive than uint256 or any type that takes up a full
    // word because each write operation emits an extra SLOAD to first read the
    // slot's contents, replace the bits taken up by the boolean, and then write
    // back. This is the compiler's defense against contract upgrades and
    // pointer aliasing, and it cannot be disabled.

    // The values being non-zero value makes deployment a bit more expensive,
    // but in exchange the refund on every call to nonReentrant will be lower in
    // amount. Since refunds are capped to a percentage of the total
    // transaction's gas, it is best to keep them low in cases like this one, to
    // increase the likelihood of the full refund coming into effect.
    uint256 private constant _NOT_ENTERED = 1;
    uint256 private constant _ENTERED = 2;

    uint256 private _status;

    constructor() {
        _status = _NOT_ENTERED;
    }

    /**
     * @dev Prevents a contract from calling itself, directly or indirectly.
     * Calling a `nonReentrant` function from another `nonReentrant`
     * function is not supported. It is possible to prevent this from happening
     * by making the `nonReentrant` function external, and making it call a
     * `private` function that does the actual work.
     */
    modifier nonReentrant() {
        // On the first call to nonReentrant, _notEntered will be true
        require(_status != _ENTERED, "ReentrancyGuard: reentrant call");

        // Any calls to nonReentrant after this point will fail
        _status = _ENTERED;

        _;

        // By storing the original value once again, a refund is triggered (see
        // https://eips.ethereum.org/EIPS/eip-2200)
        _status = _NOT_ENTERED;
    }
} 
interface IPancakeRouter01 {
    function factory() external pure returns (address);
    function WETH() external pure returns (address);

    function addLiquidity(
        address tokenA,
        address tokenB,
        uint amountADesired,
        uint amountBDesired,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB, uint liquidity);
    function addLiquidityETH(
        address token,
        uint amountTokenDesired,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external payable returns (uint amountToken, uint amountETH, uint liquidity);
    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB);
    function removeLiquidityETH(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountToken, uint amountETH);
    function removeLiquidityWithPermit(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountA, uint amountB);
    function removeLiquidityETHWithPermit(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountToken, uint amountETH);
    function swapExactTokensForTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
    function swapTokensForExactTokens(
        uint amountOut,
        uint amountInMax,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
    function swapExactETHForTokens(uint amountOutMin, address[] calldata path, address to, uint deadline)
        external
        payable
        returns (uint[] memory amounts);
    function swapTokensForExactETH(uint amountOut, uint amountInMax, address[] calldata path, address to, uint deadline)
        external
        returns (uint[] memory amounts);
    function swapExactTokensForETH(uint amountIn, uint amountOutMin, address[] calldata path, address to, uint deadline)
        external
        returns (uint[] memory amounts);
    function swapETHForExactTokens(uint amountOut, address[] calldata path, address to, uint deadline)
        external
        payable
        returns (uint[] memory amounts);

    function quote(uint amountA, uint reserveA, uint reserveB) external pure returns (uint amountB);
    function getAmountOut(uint amountIn, uint reserveIn, uint reserveOut) external pure returns (uint amountOut);
    function getAmountIn(uint amountOut, uint reserveIn, uint reserveOut) external pure returns (uint amountIn);
    function getAmountsOut(uint amountIn, address[] calldata path) external view returns (uint[] memory amounts);
    function getAmountsIn(uint amountOut, address[] calldata path) external view returns (uint[] memory amounts);
}

interface IPancakeRouter02 is IPancakeRouter01 {
    function removeLiquidityETHSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountETH);
    function removeLiquidityETHWithPermitSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountETH);

    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
    function swapExactETHForTokensSupportingFeeOnTransferTokens(
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external payable;
    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
}

contract PurchaseWojak is Context, ReentrancyGuard {
    IPancakeRouter02 router;
    bool private paused;
    address private owner;

    uint256 public minPurchaseAmount;
    uint256 public maxPurchaseAmount;

    address wojakToken;
    address wBNB = 0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c;

    constructor(
        address _pancakeswapRouter,
        address _owner,
        uint256 _minValue,
        uint256 _maxValue,
        address _wojakToken
    ) {
        router = IPancakeRouter02(_pancakeswapRouter);
        owner = _owner;
        minPurchaseAmount = _minValue;
        maxPurchaseAmount = _maxValue;
        wojakToken = _wojakToken;
    }

    /**
     * @dev checks if `caller` is `owner`
     * reverts if the `caller` is not the `owner` account.
     */
    modifier onlyAdmin() {
        require(owner == msgSender(), "Error: caller not owner");
        _;
    }

    /**
     * @dev checks if `purchase` is `paused`
     * reverts if the `purchase` is paused
     */
    modifier notPaused() {
        require(!paused, "Error: purchases are paused");
        _;
    }

    function getEstimate(uint256 _bnbValue) public view returns (uint256) {
        address[] memory path = new address[](2);
        path[0] = wBNB;
        path[1] = wojakToken;
        return router.getAmountsOut(_bnbValue, path)[1];
    }

    /**
     * @dev used to purchase Wojak Tokens using BNB.
     */
    function purchaseWithBNB()
        public
        payable
        virtual
        nonReentrant
        notPaused
        returns (bool)
    {
        require(
            _msgValue() >= minPurchaseAmount,
            "Error:Less than minimum purchase amount"
        );
        require(
            _msgValue() <= maxPurchaseAmount,
            "Error:More than max purchase amount"
        );

        uint256 wojakAmount = getEstimate(_msgValue());
        address[] memory path = new address[](2);

        path[0] = wBNB;
        path[1] = wojakToken;
        router.swapExactETHForTokens{value: _msgValue()}(
            wojakAmount,
            path,
            msgSender(),
            block.timestamp + 15 minutes
        );
        return true;
    }

    /**
     * @dev returns the wojak token smart contract
     */
    function wojakAddress() public view returns (address) {
        return wojakToken;
    }

    /**
     * @dev returns the owner address
     */
    function ownerAddress() public view returns (address) {
        return owner;
    }
    
    
    
     /**
     * @dev returns if the purchase are paused
     */
    function isPaused() public view returns (bool) {
        return paused;
    }

    /**
     * @dev updates the wojak token address.
     *
     * Requirements:
     * `newAddress` cannot be a zero address.
     * `caller` should be current admin.
     */
    function updateWojak(address newAddress) public virtual onlyAdmin {
        require(newAddress != address(0), "Error: address cannot be zero");
        wojakToken = newAddress;
    }

    /**
     * @dev updates the Pancakeswap Router address.
     *
     * Requirements:
     * `newAddress` cannot be a zero address.
     * `caller` should be current admin.
     */
    function updatePancakeswapRouter(address newAddress)
        public
        virtual
        onlyAdmin
    {
        require(newAddress != address(0), "Error: address cannot be zero");
        router = IPancakeRouter02(newAddress);
    }

    /**
     * @dev transfers ownership to a different account.
     *
     * Requirements:
     * `newAdmin` cannot be a zero address.
     * `caller` should be current admin.
     */
    function transferControl(address _newOwner) public virtual onlyAdmin {
        require(_newOwner != address(0), "Error: owner cannot be zero");
        owner = _newOwner;
    }

    /**
     * @dev updates the minimum purchase value in BNB.
     *
     * Requirements:
     * `newAddress` cannot be a zero address.
     * `caller` should be current admin.
     */

    function updateMinimumPurchaseValue(uint256 _newValue)
        external
        virtual
        onlyAdmin
    {
        require(_newValue > 0, "Error:Minimum purchase value should be > 0");
        minPurchaseAmount = _newValue;
    }

    /**
     * @dev updates the maximum purchase value in BNB.
     *
     * Requirements:
     * `newAddress` cannot be a zero address.
     * `caller` should be current admin.
     */

    function updateMaximumPurchaseValue(uint256 _newValue)
        external
        virtual
        onlyAdmin
    {
        require(_newValue > 0, "Error:Max purchase value should be > 0");
        maxPurchaseAmount = _newValue;
    }

    /**
     * @dev used to pause/resume purchases
     *
     * Requirements:
     * `newAddress` cannot be a zero address.
     * `caller` should be current admin.
     */

    function pausePurchases(bool _pause) external virtual onlyAdmin {
        paused = _pause;
    }
}
