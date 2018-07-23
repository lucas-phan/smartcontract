pragma solidity ^0.4.23;

contract Owned {
    address owner;

    //function Owned() {
    //    owner = msg.sender;
    //}
    
    constructor() public {
       owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }
}

contract WhiteListed is Owned {

    uint public count;
    mapping (address => bool) public whiteList;

    event Whitelisted(address indexed addr, uint whitelistedCount, bool isWhitelisted);

    function addWhiteListed(address[] addrs) external onlyOwner {
        uint c = count;
        for (uint i = 0; i < addrs.length; i++) {
            if (!whiteList[addrs[i]]) {
                whiteList[addrs[i]] = true;
                c++;
                emit Whitelisted(addrs[i], count, true);
            }
        }
        count = c;
    }

    function removeWhiteListed(address addr) external onlyOwner {
        require(whiteList[addr]);
        whiteList[addr] = false;
        count--;
        emit Whitelisted(addr, count, false);
    }

}
