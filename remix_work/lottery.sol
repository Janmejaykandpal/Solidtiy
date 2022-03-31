// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 <0.9.0;

contract lottery{
    address public manager;
    address payable[] public particpants;

    constructor()
    {
        manager=msg.sender;
    }
    receive() external payable
    {   require(msg.value==1 ether);
        particpants.push(payable(msg.sender));

    }

    function getBalance() public view returns (uint) {
        require(msg.sender== manager);
    
        return  address(this).balance;

    }
    function random() public view returns (uint){
        return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp,particpants.length)));
    }
    function selectWinner() public {
        require(msg.sender== manager);
        require(particpants.length>=3);
        uint r=random();
        address payable winner;
        uint index =r % particpants.length;
        winner=particpants[index];
        winner.transfer(getBalance());
        particpants=new address payable[](0);
    }


 }