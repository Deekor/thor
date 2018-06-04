// Copyright (c) 2018 The VeChainThor developers
 
// Distributed under the GNU Lesser General Public License v3.0 software license, see the accompanying
// file LICENSE or <https://www.gnu.org/licenses/lgpl-3.0.html>

pragma solidity ^0.4.18;
import "./Energy.sol";

contract Prototype {

    /// @return master of account.
    /// For an external account, its master is initially zero.
    /// For a contract, its master is the msg sender of deployment.
    function $master(address self) public view returns(address master){
        return PrototypeNative(this).native_master(self);
    }

    /// @param newMaster new master to be set.
    function $setMaster(address self, address newMaster) public {
        require(PrototypeNative(this).native_master(self) == msg.sender || self == msg.sender);
        PrototypeNative(this).native_setMaster(self, newMaster);
    }

    function $balance(address self, uint32 blockNumber) public view returns(uint256 amount){
        return  PrototypeNative(this).native_balanceAtBlock(self, blockNumber);
    }

    function $energy(address self, uint32 blockNumber) public view returns(uint256 amount){
        return  PrototypeNative(this).native_energyAtBlock(self, blockNumber);
    }

    function $hasCode(address self) public view returns(bool){
        return PrototypeNative(this).native_hasCode(self);
    }

    function $storage(address self, bytes32 key) public view returns(bytes32 value){
        return PrototypeNative(this).native_storage(self, key);
    }

    function $storage(address self, bytes32 key, uint32 blockNumber) public view returns(bytes32 value){
        return PrototypeNative(this).native_storageAtBlock(self, key, blockNumber);
    }

    function $userPlan(address self) public view returns(uint256 credit, uint256 recoveryRate){
        return PrototypeNative(this).native_userPlan(self);
    }

    function $setUserPlan(address self, uint256 credit, uint256 recoveryRate) public{
        require(PrototypeNative(this).native_master(self) == msg.sender || self == msg.sender);
        PrototypeNative(this).native_setUserPlan(self, credit, recoveryRate);
    }

    function $isUser(address self, address user) public view returns(bool){
        return PrototypeNative(this).native_isUser(self, user);
    }

    function $userCredit(address self, address user) public view returns(uint256 remainedCredit){
        return PrototypeNative(this).native_userCredit(self, user);
    }

    function $addUser(address self, address user) public{
        require(PrototypeNative(this).native_master(self) == msg.sender || self == msg.sender);
        require(!PrototypeNative(this).native_isUser(self, user));
        PrototypeNative(this).native_addUser(self, user);
    }

    function $removeUser(address self, address user) public{
        require(PrototypeNative(this).native_master(self) == msg.sender || self == msg.sender);
        require(PrototypeNative(this).native_isUser(self, user));
        PrototypeNative(this).native_removeUser(self, user);
    }

    function $sponsor(address self, bool yesOrNo) public{
        if(yesOrNo) {
            require(!PrototypeNative(this).native_isSponsor(self, msg.sender));
        } else {
            require(PrototypeNative(this).native_isSponsor(self, msg.sender));
        }
        PrototypeNative(this).native_sponsor(self, msg.sender, yesOrNo);
    }

    function $isSponsor(address self, address sponsor) public view returns(bool){
        return PrototypeNative(this).native_isSponsor(self, sponsor);
    }

    function $selectSponsor(address self, address sponsor) public{
        require(PrototypeNative(this).native_master(self) == msg.sender || self == msg.sender);
        require(PrototypeNative(this).native_isSponsor(self, sponsor));
        PrototypeNative(this).native_selectSponsor(self, sponsor);
    }
    
    function $currentSponsor(address self) public view returns(address){
        return PrototypeNative(this).native_currentSponsor(self);
    }

}

contract PrototypeNative {
    function native_master(address self) public view returns(address master);
    function native_setMaster(address self, address newMaster) public;

    function native_balanceAtBlock(address self, uint32 blockNumber) public view returns(uint256 amount);
    function native_energyAtBlock(address self, uint32 blockNumber) public view returns(uint256 amount);
    function native_hasCode(address self) public view returns(bool);
    function native_storage(address self, bytes32 key) public view returns(bytes32 value);
    function native_storageAtBlock(address self, bytes32 key, uint32 blockNumber) public view returns(bytes32 value);

    function native_userPlan(address self) public view returns(uint256 credit, uint256 recoveryRate);
    function native_setUserPlan(address self, uint256 credit, uint256 recoveryRate) public;

    function native_isUser(address self, address user) public view returns(bool);
    function native_userCredit(address self, address user) public view returns(uint256 remainedCredit);
    function native_addUser(address self, address user) public;
    function native_removeUser(address self, address user) public;

    function native_sponsor(address self, address caller, bool yesOrNo) public;
    function native_isSponsor(address self, address sponsor) public view returns(bool);
    function native_selectSponsor(address self, address sponsor) public;
    function native_currentSponsor(address self) public view returns(address);
}