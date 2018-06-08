contract TestConditiondal {
    
    address admin;
    
    constructor() public {
        admin = msg.sender;
    }
    
    uint public x;
    
    modifier onlyAdmin1() {
        require(msg.sender==admin);
        _;
    }
    
    modifier onlyAdmin2() {
        assert(msg.sender==admin);
        _;
    }
    
    function setValue1(uint a) public onlyAdmin1{
        x=a;
    }
    
    function setValue2(uint a) public onlyAdmin2 {
        x=a;
    }
     
    
}
