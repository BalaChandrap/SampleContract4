pragma solidity ^0.4.23;


contract Sample {
    
    
    uint x;
   
    
    function setValue(uint a) public  {
        
         if(msg.value != 1 wei){
             throw;
         }
        
        x=a;
    }
    
    function getValue() view public returns(uint){
        x=3;
        return x;
    }
    
    function getValue2() view public returns(uint){
        
        //uint y;
        
          
        return x;
    }
}



contract Students {
    
    address admin;
    
    mapping(address=>mapping(uint=>bool)) attendance;
    
    constructor() public{
        admin = msg.sender;
    }
    
    modifier onlyAdmin() {
       if(msg.sender!=admin){
            throw;
        }
        
        _;
    }
    
    modifier checkValue() {
        if(msg.value!=1 ether){
            throw;
        }
        _;
    }
    
    function addAttendance(uint _day,address _studentAddress) public onlyAdmin {
    
        
        
        attendance[_studentAddress][_day] =true;
        
    }
    
    function checkAttendance(uint _day,address _studentAddress)public view  returns (bool){
        
        return attendance[_studentAddress][_day];
        
    }
}






contract MapTest {
    
    mapping(address=>bool) visits;
    
    address [] visitArray;
    
    
    function visit() public {
        visits[msg.sender] = true;
        visitArray.push(msg.sender);
    }
    
    function getVisitStatus(address _userAddress) view public returns(bool){
        
        return visits[_userAddress];
    }
    
    function getVisitors() view public returns(address[]){
        return visitArray;
    }
    
    
}



















