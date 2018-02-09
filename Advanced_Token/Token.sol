# **************************************************************************** #
#                                                           LE - /             #
#                                                               /              #
#    Token.sol                                        .::    .:/ .      .::    #
#                                                  +:+:+   +:    +:  +:+:+     #
#    By: jecombe <marvin@le-101.fr>                 +:+   +:    +:    +:+      #
#                                                  #+#   #+    #+    #+#       #
#    Created: 2018/02/09 15:11:43 by jecombe      #+#   ##    ##    #+#        #
#    Updated: 2018/02/09 15:15:14 by jecombe     ###    #+. /#+    ###.fr      #
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

