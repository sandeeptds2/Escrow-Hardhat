// SPDX-License-Identifier: MIT
pragma solidity 0.7.5;

struct Trust {
    uint level; //
	address holder; 
	string proposal; //Immutable
	mapping (bytes32 => Trust) bonds; //Child Trust Node  
}

contract Mission {

	Trust public root;

	mapping (address => bytes32[]) chain; //

	constructor(address[] memory founders, string memory statement) payable {

	// Request storage newRequest = requests[index]
	// Trust storage newTrust = bonds[index]

		// root = storage Trust(founders.length, 0, statement);
		root.level = founders.length;
		root.holder = address(this);
		root.proposal = statement;

		for (uint i=0; i<founders.length; i++) {
			
			bytes32 key = sha256(abi.encodePacked(founders[i], address(this)));
			
			root.bonds[key].level = 1;
			root.bonds[key].holder = founders[i];
			root.bonds[key].proposal = statement;

			
			chain[founders[i]] = [key];
		}
	}

}
