# **************************************************************************** #
#                                                           LE - /             #
#                                                               /              #
#    Advanced_Token1.sol                              .::    .:/ .      .::    #
#                                                  +:+:+   +:    +:  +:+:+     #
#    By: jecombe <marvin@le-101.fr>                 +:+   +:    +:    +:+      #
#                                                  #+#   #+    #+    #+#       #
#    Created: 2018/02/09 12:53:04 by jecombe      #+#   ##    ##    #+#        #
#    Updated: 2018/02/09 15:11:11 by jecombe     ###    #+. /#+    ###.fr      #
#                                                          /                   #
#                                                         /                    #
# **************************************************************************** #


pragma solidity ^0.4.4;

/*************************************************************************/
/*									 */
/*					Token		 		 */
/*			https://github.com/ethereum/EIPs/issues/20	 */
/*************************************************************************/

contract Token {

	/// @return montant total des tokens.
	function totalSupply() public constant returns (uint256 supply) {}

	/// @param _owner L'adresse à partir de laquelle le solde sera récupéré.

	/// @return La balance.
	function balanceOf(address _owner) public constant returns (uint256 balance) {}

	/// @notice send `_value` token to `_to` from `msg.sender`.
	/// @param _to L’adresse du destinataire.
	/// @param _value La quantité de jeton a transférer.
	/// @return Si le transfère a réussi ou non
	function transfer(address _to, uint256 _value) public returns (bool success) {}

	/// @notice send `_value` token to `_to` from `_from` on the condition it is approved by `_from`
	/// @param _from L’adresse de l’expéditeur. 
	/// @param _to L’adresse du destinataire.
	/// @param _value La quantité de jeton à transférer
	/// @return Si le transfère a réussi ou non
	function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {}

	/// @notice `msg.sender` approuve `_addr` a envoyer `_value` tokens
	/// @param _spender L'adresse du compte capable de transférer les jetons
	/// @param _value La quantité de wei à approuver pour le transfert
	/// @return Si l'approbation a été réussie ou non
	function approve(address _spender, uint256 _value) public returns (bool success) {}

	/// @param _owner L'adresse du compte possédant des jetons
	/// @param _spender L'adresse du compte capable de transférer les jetons
	/// @return Quantité de jetons restants autorisés à être dépensés
	function allowance(address _owner, address _spender) public constant returns (uint256 remaining) {}

	event Transfer(address indexed _from, address indexed _to, uint256 _value);
	event Approval(address indexed _owner, address indexed _spender, uint256 _value);

}

/*************************************************************************/
/*									 */
/*				Standard Token	 			 */
/*									 */
/*************************************************************************/

contract StandardToken is Token {

	function transfer(address _to, uint256 _value) public returns (bool success) {
		//Default assumes totalSupply can't be over max (2^256 - 1).
		//If your token leaves out totalSupply and can issue more tokens as time goes on, you need to check if it doesn't wrap.
		//Replace the if with this one instead.
		//if (balances[msg.sender] >= _value && balances[_to] + _value > balances[_to]) {
		if (balances[msg.sender] >= _value && _value > 0) {
			balances[msg.sender] -= _value;
			balances[_to] += _value;
			Transfer(msg.sender, _to, _value);
			return true;
		} else { return false; }
	}

	function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
		//same as above. Replace this line with the following if you want to protect against wrapping uints.
		//if (balances[_from] >= _value && allowed[_from][msg.sender] >= _value && balances[_to] + _value > balances[_to]) {
		if (balances[_from] >= _value && allowed[_from][msg.sender] >= _value && _value > 0) {
			balances[_to] += _value;
			balances[_from] -= _value;
			allowed[_from][msg.sender] -= _value;
			Transfer(_from, _to, _value);
			return true;
		} else { return false; }
	}

	function balanceOf(address _owner) public constant returns (uint256 balance) {
		return balances[_owner];
	}

	function approve(address _spender, uint256 _value) public returns (bool success) {
		allowed[msg.sender][_spender] = _value;
		Approval(msg.sender, _spender, _value);
		return true;
	}

	function allowance(address _owner, address _spender) public constant returns (uint256 remaining) {
		return allowed[_owner][_spender];
	}

	mapping (address => uint256) balances;
	mapping (address => mapping (address => uint256)) allowed;
	uint256 public totalSupply;
}

/*************************************************************************/
/*									 */
/*				Advanced_Token1	 			 */
/*									 */
/*************************************************************************/

contract Advanced_Token1 is StandardToken { // CHANGE THIS. Update the contract name.

	/* Public variables of the token */

	/*
	NOTE:
	The following variables are OPTIONAL vanities. One does not have to include them.
		They allow one to customise the token contract & in no way influences the core functionality.
		Some wallets/interfaces might not even bother to look at this information.
		*/
	string public name;                   // Token Name
	uint8 public decimals;                // How many decimals to show. To be standard complicant keep it 18
	string public symbol;                 // An identifier: eg SBX, XPR etc..
	string public version = 'H1.0'; 
	uint256 public unitsOneEthCanBuy;     // How many units of your coin can be bought by 1 ETH?
	uint256 public totalEthInWei;         // WEI is the smallest unit of ETH (the equivalent of cent in USD or satoshi in BTC). We'll store the total ETH raised via our ICO here.  
	address public fundsWallet;           // Where should the raised ETH go?

	// This is a constructor function 
	// which means the following function name has to match the contract name declared above
	function Advanced_Token1() public {
		balances[msg.sender] = 10000000000000000000000;               // Give the creator all initial tokens. This is set to 10000 for example. If you want your initial tokens to be X and your decimal is 5, set this value to X * 100000. (CHANGE THIS)
		totalSupply = 10000000000000000000000;                        // Update total supply (10000 for example) (CHANGE THIS)
		name = "Advanced_Token1";                                   // Set the name for display purposes (CHANGE THIS)
		decimals = 18;                                               // Amount of decimals for display purposes (CHANGE THIS)
		symbol = "ADT1";                                             // Set the symbol for display purposes (CHANGE THIS)
		unitsOneEthCanBuy = 100;                                      // Set the price of your token for the ICO (CHANGE THIS)
		fundsWallet = msg.sender;                                    // The owner of the contract gets ETH
	}

	function() payable public{
		totalEthInWei = totalEthInWei + msg.value;
		uint256 amount = msg.value * unitsOneEthCanBuy;
		if (balances[fundsWallet] < amount) {
			return;
		}

		balances[fundsWallet] = balances[fundsWallet] - amount;
		balances[msg.sender] = balances[msg.sender] + amount;

		Transfer(fundsWallet, msg.sender, amount); // Broadcast a message to the blockchain

		//Transfer ether to fundsWallet
		fundsWallet.transfer(msg.value);
	}

	/* Approves and then calls the receiving contract */
	function approveAndCall(address _spender, uint256 _value, bytes _extraData) public returns (bool success) {
		allowed[msg.sender][_spender] = _value;
		Approval(msg.sender, _spender, _value);

		//call the receiveApproval function on the contract you want to be notified. This crafts the function signature manually so one doesn't have to include a contract in here just for this.
		//receiveApproval(address _from, uint256 _value, address _tokenContract, bytes _extraData)
		//it is assumed that when does this that the call *should* succeed, otherwise one would use vanilla approve instead.
		if(!_spender.call(bytes4(bytes32(sha3("receiveApproval(address,uint256,address,bytes)"))), msg.sender, _value, this, _extraData)) { throw; }
		return true;
	}
}
