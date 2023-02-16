const { assert, expect } = require("chai");
const { ethers } = require("hardhat");
const Web3 = require('web3');

describe("Insurance Contract tests", function () {
    let insuranceContract;
    let owner1;
    let owner2;



    beforeEach(async function () {
        [owner1, owner2] = await ethers.getSigners();
        insuranceContract = await ethers.getContractFactory(
            "InsuranceContract"
        );

        contract = await insuranceContract.deploy();

    });

    describe("signUp", async () => {
        it("should allow customer to signUp", async () => {
            const initialPayment = Web3.utils.toWei("0.0001", "ether");
            const insuranceContract = await contract.connect(owner1).signUp("manju", 25, 2628000, {
                from: owner1.address,
                value: initialPayment,
            });
            await insuranceContract.wait();

            const customers = await contract.connect(owner1).customerDetails();
            assert(customers.length == 1);
            assert(customers[0].name == "manju");
            assert(customers[0].age == 25);
            assert(customers[0].paymentPeriod == 2628000);
        });
    });
    it("should not allow customer to signUp again", async () => {
        const initialPayment = Web3.utils.toWei("0.0001", "ether");
        const insuranceContract = await contract.connect(owner1).signUp("manju", 25, 2628000, {
            from: owner1.address,
            value: initialPayment,
        });
        await insuranceContract.wait();

        assert()
        it(" should allow to pay premium", async () => {
            const initialPayment = Web3.utils.toWei("0.0001", "ether");
            const insuranceContract = await contract.connect(owner1).signUp("manju", 25, 2628000, {
                from: owner1.address,
                value: initialPayment,
            });
            await insuranceContract.wait();
            const customers = await contract.payPremium();


        })




    });



})