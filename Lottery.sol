contract Lottery {
    
    address public admin;
    
    address [] public participants;
    
    uint8 public totalParticipants;
    
    bool public lotteryState;
    
    constructor () public {
        admin = msg.sender;
    }
    
    modifier onlyAdmin {
        require(msg.sender == admin);
        _;
    }
    
    modifier onlyTrueState {
        require(lotteryState);
        _;
    }
    
    event ParticipantRegistered(address _participantAddress,uint256 timestamp);
    event LotteryProcessed(address _winnerAddress,uint256 timestamp);
    
    function startLottery() public onlyAdmin {
        lotteryState = true;
    }
    
    function stopLottery() public onlyAdmin {
        lotteryState = false;
    }
    
    function registerForLottery() payable public onlyTrueState {
        require(msg.value == 1 ether);
        
        totalParticipants++;
        participants.push(msg.sender);
        emit ParticipantRegistered(msg.sender,block.timestamp);
    }
    
    function processLottery() public onlyAdmin {
        require(lotteryState == false);
        require(totalParticipants>1);
        
        //uint8 winninerNumber = totalParticipants/2;
        
        uint256 winninerNumber = uint256(keccak256(block.number+block.difficulty))%(totalParticipants-1);
        
        participants[winninerNumber].transfer(totalParticipants*1 ether);
    }
}
