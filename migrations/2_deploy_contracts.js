var HjortCoin = artifacts.require("HjortCoin");

module.exports = function(deployer) {
    deployer.deploy(HjortCoin, "HjortCoin", "HJC", 18, 9001);
}
