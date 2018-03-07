pragma solidity ^0.4.17;

import "truffle/DeployedAddresses.sol";
import "truffle/Assert.sol";

import "../contracts/HjortCoin.sol";

contract HjortCoinTest {

    function testInitialValues() {
        HjortCoin hc = HjortCoin(DeployedAddresses.HjortCoin());
        uint expected = 9001 * 10 ** 18;
        Assert.equal(hc.balanceOf(tx.origin), expected, "Owner should have 9001 coins.");
    }

    function testTransfer() {
        // Makes this contract the owner.
        HjortCoin hc = new HjortCoin("HjortCoin", "THJC", 18, 9001);
        address a = 0x1234;
        hc.transfer(a, 10);
        Assert.equal(hc.balanceOf(a), 10, "Receiver should now have 10 coins.");

        // Edge case check. We empty the account except for 1 fawn. We then ensure transaction works before, but not after, using identical calls.
        // Step 1. Empty all coins in the account except for 1 fawn.
        hc.transfer(a, 9001 * 10 ** 18 - 11);

        bool result;
        // Step 2. Transfer last fawn coin.
        result = hc.call(bytes4(bytes32(keccak256("transfer(address,uint256)"))), a, 1);
        Assert.isTrue(result, "There is exactly 1 fawn in the account, and we expect success.");
        // Step 3. Transfer 1 more fawn.
        result = hc.call(bytes4(bytes32(keccak256("transfer(address,uint256)"))), a, 1);
        Assert.isFalse(result, "The account is empty, but we could transfer from it.");
    }
}
