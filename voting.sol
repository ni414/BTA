pragma solidity >=0.5.0;
contract voting{
    address public moderator;
    struct Candidate{
        string name;uint vote_count;
    }
    struct Voter{
        bool if_voted;
        bool if_voter;
        string voted_to;
    }
    constructor(){
        moderator = msg.sender;
    } 
    Candidate [] public candidates;//can be accessed through index
    modifier onlyModerator{
        require(msg.sender==moderator,"Only moderator can perform this task");
        _; 
    }
    modifier onlyVoter{
        require(voters[msg.sender].if_voter==true,"Only voters can perform this task");
        _;
    }
    function addCandidate(string memory cname) public onlyModerator{
        candidates.push(Candidate({name:cname,vote_count:0}));
    }
    mapping(address=>Voter) public voters;
    function giveRightToVote(address _voter) public onlyModerator{
        voters[_voter].if_voter=true;
    }
    function vote(uint cadd) public onlyVoter{
        Voter storage vot = voters[msg.sender];
        vot.if_voted=true;
        vot.voted_to=candidates[cadd].name;
        candidates[cadd].vote_count+=1;
    }
    string public winner;
    uint public winner_vote_count;
    function identifyWinner() public onlyModerator{
        uint winner_votes=0;
        uint winner_index=0;
        
        for(uint i=0;i<candidates.length;i++){
            if(candidates[i].vote_count>winner_votes){
                winner_votes=candidates[i].vote_count;
                winner_index=i;
            }
        }
        winner=candidates[winner_index].name;
        winner_vote_count=candidates[winner_index].vote_count;
    }
}
