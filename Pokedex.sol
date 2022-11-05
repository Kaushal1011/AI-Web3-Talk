// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Pokedex{
    string public pokedex_name;
    uint public pokedex_version;
    // string[] public pokedex_regions;
    address[] admin;

    struct Pokemon{
        string name;
        string[] power_type;
        uint height_max;
        uint height_min;
        bool exists;
    }

    mapping (string => Pokemon) pokemonData;
    mapping (address => bool) public admins;
    
    constructor(string memory _name, uint  _version){
        pokedex_name=_name;
        pokedex_version=_version;
        admins[msg.sender]=true;
    }

    function contains(address _wallet) internal view  returns (bool){
            return admins[_wallet];
        }

    
    function addPokemon(string memory _name,string[] memory _power_type,uint _height_max,uint _height_min) public returns ( bool){
        if (!contains(msg.sender)){
            revert("not authorised to add");
        }
        require(_height_max>_height_min,"max height should be greater than min");
        pokemonData[_name]=Pokemon({
            name:_name,
            power_type:_power_type,
            height_max: _height_max,
            height_min:_height_min,
            exists:true
        });
        return true;
    }

    function getPokemon(string memory _name) public view returns (bool,  Pokemon memory) {
        if (pokemonData[_name].exists){
            return (true,pokemonData[_name]);
        }else{
            string[] memory power_type;
            return (false,Pokemon({
            name:"",
            power_type:power_type,
            height_max: 0,
            height_min:0,
            exists:false}));
        }
    }

    function addAdmin(address _newAdmin) public returns (bool){
        if (!contains(msg.sender)){
            revert("not authorised to add");
        }
        admins[_newAdmin]=true;
        return true;
    }

}