var HjortCoin = artifacts.require("HjortCoin");
var HjortUser = artifacts.require("HjortUser");

module.exports = function(deployer) {
    deployer.deploy(HjortCoin, "HjortCoin", "HJC", 18, 9001);
    deployer.deploy(HjortUser, HjortCoin.address);
}
