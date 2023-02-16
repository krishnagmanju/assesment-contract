//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract InsuranceContract {
    struct Customer {
        string name;
        uint256 age;
        address payable wallet;
        bool hasPolicy;
        uint256 lastPaymentTime; //Time
        uint256 premiumPaid;
        uint256 paymentPeriod;
    }

    Customer[] public customers;

    mapping(address => Customer) public customerInfo;

    /**
     * @notice signup for a customer.
     * @param  _name name of customer
     * @param  _age age of customer
     * @param  _paymentPeriod paymend period for insurance
     */
    function signUp(
        string memory _name,
        uint256 _age,
        uint256 _paymentPeriod
    ) public payable {
        // Make sure the customer has not already signed up
        require(
            customerInfo[msg.sender].wallet == address(0),
            "You have already signed up"
        );

        // Make sure the initial payment is 0.0001 ETH
        require(
            msg.value == 0.0001 ether,
            "Initial payment must be 0.0001 ETH"
        );
        Customer memory customer = Customer(
            _name,
            _age,
            payable(msg.sender),
            true,
            block.timestamp,
            msg.value,
            _paymentPeriod
        );
        customers.push(customer);
        customerInfo[msg.sender] = customer;
    }

    /**
     * @notice paying premium
     */

    function payPremium() public payable {
        // Make sure the customer has signed up
        require(
            customerInfo[msg.sender].wallet != address(0),
            "You have not signed up for the insurance"
        );

        // Make sure the premium payment is 0.001 ETH
        require(msg.value == 0.001 ether, "Premium payment must be 0.001 ETH");
        // Update the customer's premiumPaid field
        customerInfo[msg.sender].premiumPaid += msg.value;
    }

    /**
     * @notice check whether customer is insured.
     * @param  _customer address of customer
     * @return  bool paymend period for insurance
     */
    function isInsured(address _customer) public view returns (bool) {
        require(customerInfo[_customer].hasPolicy == true, "no policies");
        require(
            customerInfo[_customer].lastPaymentTime +
                customerInfo[_customer].paymentPeriod >=
                block.timestamp,
            "not insusred"
        );
        return true;
    }

    /**
     * @notice return customer details
     * @return  Customer[] customer array
     */

    function customerDetails() public view returns (Customer[] memory) {
        return customers;
    }

    /**
     * @notice claim insurance
     * @param  _customer address of customer
     */

    function claimInsurance(address _customer) public payable {
        require(isInsured(_customer), "customer is not insured");
        uint256 claimAmount = 0.001 *
            10**18 *
            customerInfo[msg.sender].paymentPeriod;
        uint256 lastpayment = customerInfo[msg.sender].premiumPaid;
        require(lastpayment < claimAmount, "not eligilble for claim");

        // premium paid  transfer to user
        payable(_customer).transfer(claimAmount);
    }
}
