# Crowdfunding-smart-contract

This smart contract is a CrowdFunding contract that facilitates crowdfunding campaigns with various features and functionality. 
It allows users to create and manage crowdfunding campaigns. Some key features of this contract include:

1. **Manager and Minimum Contribution**: The contract has a manager (the creator of the campaign) and a minimum contribution requirement for participants.

2. **Target and Deadline**: The campaign has a fundraising target and a deadline by which the target needs to be reached.

3. **Contributions**: Users can contribute to the campaign by sending Ether. If they meet the minimum contribution requirement, their contributions are recorded.

4. **Refunds**: If the campaign does not reach its target by the deadline, contributors can request refunds. Refunds are allowed only if the campaign has not reached its target and the deadline has passed.

5. **Requests**: The manager can create requests to withdraw funds from the campaign for specific purposes. Contributors can vote on these requests.

6. **Voting System**: Contributors can vote on requests. Requests require more than 50% of contributors to approve them before they can be fulfilled.

7. **Fulfillment of Requests**: The manager can fulfill requests once they have received enough votes. This action transfers funds to the specified recipient.

This smart contract provides a secure and transparent way to manage crowdfunding campaigns, ensuring that funds are only released for intended purposes if approved by the majority of contributors.
