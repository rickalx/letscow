// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract UserManagement {
    address[] public users;
    address public principalAccount;

    // Inicialización con la cuenta principal
    constructor(address _principalAccount) {
        principalAccount = _principalAccount;
        users.push(_principalAccount);  // Agregar la cuenta principal
    }

    // Función para agregar otros usuarios
    function addUser(address user) public {
        users.push(user);
    }

    // Función para obtener los usuarios
    function getUsers() public view returns (address[] memory) {
        return users;
    }

    // Función para obtener la cuenta principal
    function getPrincipalAccount() public view returns (address) {
        return principalAccount;
    }
}
