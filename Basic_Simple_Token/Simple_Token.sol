# **************************************************************************** #
#                                                           LE - /             #
#                                                               /              #
#    Simple_Token.sol                                 .::    .:/ .      .::    #
#                                                  +:+:+   +:    +:  +:+:+     #
#    By: jecombe <marvin@le-101.fr>                 +:+   +:    +:    +:+      #
#                                                  #+#   #+    #+    #+#       #
#    Created: 2018/02/09 12:30:20 by jecombe      #+#   ##    ##    #+#        #
#    Updated: 2018/02/09 12:52:12 by jecombe     ###    #+. /#+    ###.fr      #
#                                                          /                   #
#                                                         /                    #
# **************************************************************************** #



contract MyToken {
	/* Cree un tableau pour les blalanceThis creates an array with all balances */
	mapping (address => uint256) public balanceOf;

	/* Initializes contract with initial supply tokens to the creator of the contract */
	function MyToken(uint256 initialSupply) public {
		balanceOf[msg.sender] = initialSupply;              // Give the creator all initial tokens
	}

	/* Send coins */
	function transfer(address _to, uint256 _value) public {
		require(balanceOf[msg.sender] >= _value);           // Check if the sender has enough
		require(balanceOf[_to] + _value >= balanceOf[_to]); // Check for overflows
		balanceOf[msg.sender] -= _value;                    // Subtract from the sender
		balanceOf[_to] += _value;                           // Add the same to the recipient
	}
}
