const FLYHigh = artifacts.require("FLYHigh");

module.exports = function (deployer) {
  deployer.deploy(FLYHigh, 10000000000);
}