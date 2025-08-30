// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PaymentHandler {
    
    // Función que maneja los pagos proporcionales (cada usuario recibe la misma parte)
    function processProportionalPayments(address[] memory users, uint256 totalAmount, address principalAccount) public payable{
        uint256 amountToPay = totalAmount / users.length;  // Divide entre todos los usuarios (A, B, C)
        
        // Recorremos a los usuarios
        for (uint i = 0; i < users.length; i++) {
            if (users[i] != principalAccount) {
                // B y C le pagan a A
                payable(principalAccount).transfer(amountToPay);
            }
        }
    }

    // Función que maneja los pagos basados en porcentajes
    function processPercentagePayments(address[] memory users, uint256[] memory percentages, uint256 totalAmount, address principalAccount) public payable{
        
        // Recorremos los usuarios (B y C), y hacemos el pago proporcional
        for (uint i = 1; i < users.length; i++) {
            uint256 amountToPay = (totalAmount * percentages[i]) / 100;
            
            if (users[i] != principalAccount) {
                // B y C le pagan a A según los porcentajes de B y C
                payable(principalAccount).transfer(amountToPay);
            }
        }
    }
}
