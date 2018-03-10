pragma solidity ^0.4.17;

import "./HjortCoin.sol";

contract HjortUser {

    address public hjortCoinAddress;

    struct User {
        bytes32 username;
        address account;
    }

    User[] public users;

    function HjortUser(address _hjortCoinAddress) {
        hjortCoinAddress = _hjortCoinAddress;
    }

    function getUsersCount() public view returns (uint256 count) {
        return users.length;
    }

    function getUserAt(uint256 idx) public view returns (bytes32 name, address account) {
        return (users[idx].username, users[idx].account);
    }

    function register(bytes32 _username) public returns (bool success) {
        for (uint256 i; i < users.length; i++) {
            if (users[i].username == _username) {
                return false;
            }
        }
        User memory user = User(_username, msg.sender);
        users.push(user);
        return true;
    }

    function balanceOf(bytes32 _username) public view returns (uint256 balance) {
        HjortCoin hc = HjortCoin(hjortCoinAddress);
        for (uint256 i; i < users.length; i++) {
            if (users[i].username == _username) {
                return hc.balanceOf(users[i].account);
            }
        }
        return 0;
    }
}
