contract StudentReward {
    
    address teacher;
    
    constructor () public {
        teacher = msg.sender;
    }
    
    modifier onlyTeacher() {
        require(msg.sender==teacher);
        _;
    }
    
    address public highestPercentageStudent;
    uint8   public   highestPercentage;
    mapping (address=>uint8) public studentPercentages;
    address tempAdmin;
    
    event StudentAdded(address _studentAddress,address _teacherAddress,uint256 timestamp);
    
    event StudentRewarded(address _studentAddress,address _teacherAddress,uint256 timestamp);
    
    function transferOwner(address _newAdmin) public onlyTeacher {
        tempAdmin= _newAdmin;
    }
    
    function acceptOwnership() public {
        
        require(msg.sender == tempAdmin);
        teacher = msg.sender;
    }
    
    
    function addStudent(address _studentAddress,uint8 _percentage) public onlyTeacher {
        
        if(highestPercentage<_percentage){
            highestPercentage = _percentage;
            highestPercentageStudent = _studentAddress;
        }
        
        studentPercentages[_studentAddress] = _percentage;
        
        emit StudentAdded(_studentAddress,msg.sender,block.timestamp);
    }
    
    function processReward() public onlyTeacher {
        highestPercentageStudent.transfer(1 ether);
        emit StudentRewarded(highestPercentageStudent,msg.sender,block.timestamp);
    }
    
    function () payable public {
        
    }
}
