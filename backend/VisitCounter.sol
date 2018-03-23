pragma solidity ^0.4.21;

contract VisitCounter {

    uint256 private totalVisit;

    struct Visitor {
        string name;
        uint256 visitCount;
    }

    mapping (address => Visitor) visitors;

    address[] visitorAddrs;

    function VisitCounter() public {
        totalVisit = 0;
    }

    function visit(string _name) public {

        totalVisit++;

        // If this visitor already exists
        if(visitors[msg.sender].visitCount > 0) {
            visitors[msg.sender].visitCount++;
            return;
        }

        // _name must not be empty.
        assert(bytes(_name).length > 0);

        // <memory to storage> spends the least gas.
        // https://ethereum.stackexchange.com/questions/4467/initialising-structs-to-storage-variables
        Visitor memory visitor;
        visitor.name = _name;
        visitor.visitCount = 1;
        visitors[msg.sender] = visitor;

        // Store all visitor addresses
        // Push is only available in dynamic array
        visitorAddrs.push(msg.sender);
    }

    function viewTotalVisit() public view returns (uint256) {
        return totalVisit;
    }

    // To return fixed size array, we have to put the size of the array we declared like this: address[30]
    function viewAllVisitorAddresses() public view returns (address[]) {
        return visitorAddrs;
    }
}
