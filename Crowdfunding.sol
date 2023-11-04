// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
contract CrowdFunding{
    mapping (address=>uint) public contribution;
    address public manager;
    uint public minContribution;
    uint public deadline;
    uint public target;
    uint public raisedAmount;
    uint public noOfContributors;
    
    struct Request{
        string description;
        address payable recipient;
        uint value;
        bool completed;
        uint noOfVoters;
        mapping(address=>bool) voters;
    }
    mapping (uint=>Request) public requests;
    uint public numRequest;
    constructor(uint _target,uint _deadline){
        target=_target;
        deadline = block.timestamp+_deadline;
        minContribution = 100 wei;
        manager = msg.sender;
    }
    function contribute() public payable{
        require(block.timestamp<deadline,"The deadline has passed");
        require(msg.value>=minContribution,"Please pay above the minimum contribution required");
        if(contribution[msg.sender]==0){
            noOfContributors++;
        }   
        contribution[msg.sender] += msg.value;
        raisedAmount+=msg.value;
    }
    function getContractBalance() public view returns(uint){
        require(msg.sender==manager,"Only manager can access this!");
        return payable(address(this)).balance;
    }
    function refund() public{
        require(block.timestamp>deadline && raisedAmount<target,"You are not eligible for refund");
        require(contribution[msg.sender]>0);
        address payable user = payable(msg.sender);
        user.transfer(contribution[msg.sender]);
        contribution[msg.sender]=0;
    }
    modifier onlyManager{
        require(msg.sender==manager,"only manager is allowed to access this!");
        _;
    }
    function createRequest(string memory _description,address payable _recipient,uint _value) public onlyManager{
       Request storage newRequest = requests[numRequest];
       numRequest++;
       newRequest.description=_description;
       newRequest.recipient=_recipient;
       newRequest.value=_value;
       newRequest.completed=false;
       newRequest.noOfVoters=0; 
    }
    function voteRequest(uint _requestNo) public{
        require(contribution[msg.sender]>0,"You are not a contributor!");
        Request storage req = requests[_requestNo];
        require(req.voters[msg.sender]==false,"You have already voted");
        req.voters[msg.sender]=true;
        req.noOfVoters++;
    }
    function fullfillRequest(uint _reqNo) public onlyManager{
        require(raisedAmount>=target,"Target yet not achieved");
        Request storage req=requests[_reqNo];
        require(req.completed==false,"The request is already fullfilled");
        require(req.noOfVoters>=req.noOfVoters/2,"The majority did not vote");
        req.completed=true;
        payable(req.recipient).transfer(req.value);
    }
}
