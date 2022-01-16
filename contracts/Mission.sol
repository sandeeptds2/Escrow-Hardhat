// SPDX-License-Identifier: MIT
pragma solidity 0.7.5;

struct Trust {
    uint level; //
	address holder; 
	string proposal; //Immutable
	mapping (string => Trust) bonds; //Child Trust Node  
}

contract Mission {

	Trust public root;

	mapping (address => string[]) chain; //

	constructor(address[] founders, string statement) payable {
		root = new Trust(founders.length, 0, statement);
		for (int i=0; i<founders.length; i++) {
			string key = keccak256([founders[i],address(this)]]);
			root.bonds[key] = new Trust(1, founders[i], statement);
			chain[founders[i]] = [key];
		}
	}

	// function callKeccak256() public pure returns(bytes32 result){
    //   return keccak256("ABC");
   	// }
}
