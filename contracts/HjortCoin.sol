pragma solidity ^0.4.17;

// Imports.
import "./SafeMath.sol";

/** 
  * An ERC20 token.
  * The standard unit of HjortCoin is 1 deer. The smallest unit i 1 fawn, 10^18 fawn being 1 deer.
  */
contract HjortCoin {
    // Constants.
    string public name;
    string public symbol;
    uint8 public decimals;

    uint256 public totalSupply;
    mapping (address => uint256) public balanceOf;

    // allowance[owner][spender] is the amount spender can spend on behalf of owner.
    mapping (address => mapping (address => uint256)) public allowance;

    event Transfer(address indexed from, address indexed to, uint256 amount);
    event Approval(address indexed owner, address indexed spender, uint256 amount);

    function HjortCoin(
        // Constants.
        string _name,
        string _symbol,
        uint8 _decimals,
        // Supply.
        uint256 _initialSupply
    ) public {
        // Constants.
        name = _name;
        symbol = _symbol;
        // Overflow protection.
        require(_decimals < 256);
        decimals = _decimals;

        // Grant all tokens to creator.
        totalSupply = inFawn(_initialSupply);
        balanceOf[msg.sender] = totalSupply;
    }

    function inFawn(uint256 coins) private view returns (uint256 coinInDecimals){
        return SafeMath.mul(coins, 10 ** uint256(decimals));
    }

    function _transfer(address _from, address _to, uint256 _amount) internal returns (bool success) {
        // Disallow burning.
        require(_to != 0x0);
        balanceOf[_to] = SafeMath.add(balanceOf[_to], _amount);
        balanceOf[_from] = SafeMath.sub(balanceOf[_from], _amount);
        Transfer(_from, _to, _amount);
        return true;

    }

    function transfer(address _to, uint256 _amount) public returns (bool success) {
        return _transfer(msg.sender, _to, _amount);
    }

    function transferFrom(address _from, address _to, uint256 _amount) public returns (bool success) {
        require(allowance[_from][msg.sender] >= _amount);
        allowance[_from][msg.sender] -= _amount;
        return _transfer(_from, _to, _amount);
    }

    function approve(address _spender, uint256 _amount) public returns (bool success) {
        allowance[msg.sender][_spender] = _amount;
        Approval(msg.sender, _spender, _amount);
        return true;
    }

}
