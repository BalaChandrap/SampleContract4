pragma solidity ^0.4.4;

    
    contract ArrayTest {
     
     address [] addressArray;
     
     function addAddress() public {
        
        addressArray.push(msg.sender);    
     }
     
     function getAddresses() view public returns(address[],uint){
         
         return(addressArray,addressArray.length);
     }
     
     function getAddressAt(uint _index) view public returns(address){
         return addressArray[_index];
     }
     
        
    }
