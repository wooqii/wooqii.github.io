pragma solidity ^0.4.21;

contract CeightToken {
    address public owner; //
    string public name = "CeightToken";
    string public symbol = "CTX";
    uint8 public decimals = 10;
    uint public totalSupply = 0;
    
    mapping(address => uint) balances;
    mapping(address => mapping(address => uint)) internal allowed;
    
    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);
    event Mint(address indexed to, uint amount);

    constructor() public {
        owner = msg.sender;
    }
    
    function transfer(address _to, uint _value) public returns (bool) {
        require(_to != address(0)); //require 뒤에는 논리조건문이 온다.
        require(_value <= balances[msg.sender]);
        balances[msg.sender] = balances[msg.sender] - _value;
        balances[_to] = balances[_to] + _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    function balanceOf(address _owner) public view returns (uint256 balance) {
        return balances[_owner];
    }
    
    function transferFrom(address _from, address _to, uint256 _value) public returns(bool) {
        require(_to != address(0));
        require(_value <= balances[_from]);
        require(_value <= allowed[_from][msg.sender]);
        balances[_from] = balances[_from] - _value;
        balances[_to] = balances[_to] + _value;
        allowed[_from][msg.sender] = allowed[_from][msg.sender] - _value;
        emit Transfer(_from, _to, _value);
        return true;
    }

    function approve(address _spender, uint256 _value) public returns (bool) {
        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function allowance(address _owner, address _spender) public view returns (uint256) {
        return allowed[_owner][_spender];
    }

    function mint(address _to, uint256 _amount) public returns (bool) {
        require(msg.sender == owner);
        totalSupply = totalSupply + _amount;
        balances[_to] = balances[_to] + _amount;
        emit Mint(_to, _amount);
        emit Transfer(address(0), _to, _amount);
        return true;
    }
}