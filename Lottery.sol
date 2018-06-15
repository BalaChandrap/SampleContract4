pragma solidity ^0.4.20;
contract Lottery {
    
    address public admin;
    
    address [] public participants;
    
    uint8 public totalParticipants;
    
    bool public lotteryState;
    
    uint256 private randomCounter;
    
    mapping (address=>bool) entry;
    
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
    
    function registerForLottery(uint256 _randomInput) payable public onlyTrueState {
        require(msg.value == 1 ether);
        require(msg.sender!=admin);
        require(entry[msg.sender]==false);
        totalParticipants++;
        participants.push(msg.sender);
        entry[msg.sender]= true;
        randomCounter+= _randomInput;
        emit ParticipantRegistered(msg.sender,block.timestamp);
    }
    
    function processLottery() public onlyAdmin {
        require(lotteryState == false);
        require(totalParticipants>1);
        
        //uint8 winninerNumber = totalParticipants/2;
        
        uint256 winninerNumber = uint256(keccak256(block.number+block.difficulty+randomCounter))%(totalParticipants-1);
        
        participants[winninerNumber].transfer(totalParticipants*1 ether);
    }
}
