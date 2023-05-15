// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

import {Script} from "forge-std/Script.sol";
import {AAVEv3_SimpleFlashLoanExample} from "../src/AAVEv3_SimpleFlashLoanExample.sol";

contract AAVEv3_SimpleFlashLoanExampleScript is Script {
  address private poolAddressProvider = 0x0496275d34753A48320CA58103d5220d394FF77F;
  AAVEv3_SimpleFlashLoanExample private aave_fl;

  function setUp() public {}

  function run() public {
    uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

    address USDC = 0xda9d4f9b69ac6C22e444eD9aF0CfC043b7a7f53f;
    vm.startBroadcast(deployerPrivateKey);

    aave_fl = new AAVEv3_SimpleFlashLoanExample(poolAddressProvider);
    // deployerPrivateKey.transfer(aave_fl)
    (bool sent, bytes memory data) = address(aave_fl).call{value: 1000000}("");
    require(sent, "Failed to send Ether");

    aave_fl.fn_RequestFlashLoan(USDC, (10 * 10) ^ 6);

    vm.stopBroadcast();
  }
}
