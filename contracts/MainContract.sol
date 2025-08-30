// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./UserManagement.sol";
import "./PaymentHandler.sol";

contract MainContract {
    UserManagement userManagement;
    PaymentHandler paymentHandler;

    uint256 public totalAmount;

    // Inicializamos con las direcciones de UserManagement y PaymentHandler
    constructor(address _userManagement, address _paymentHandler) {
        userManagement = UserManagement(_userManagement);
        paymentHandler = PaymentHandler(_paymentHandler);
    }

    // Función para definir el monto total
    function setTotalAmount(uint256 _amount) public {
        totalAmount = _amount;
    }

    // Función para ejecutar los pagos, ya sea proporcional o por porcentajes
    function executePayments(bool isProportional, uint256[] memory percentages) public payable{
        address principalAccount = userManagement.getPrincipalAccount();
        address[] memory users = userManagement.getUsers();

        // Ejecutar los pagos dependiendo de si es proporcional o por porcentaje
        if (isProportional) {
            paymentHandler.processProportionalPayments(users, totalAmount, principalAccount);
        } else {
            require(percentages.length == users.length, "Invalid percentages length.");
            uint256 totalPercentage;
            for (uint i = 0; i < percentages.length; i++) {
                totalPercentage += percentages[i];
            }
            require(totalPercentage == 100, "Percentages must sum to 100.");

            paymentHandler.processPercentagePayments(users, percentages, totalAmount, principalAccount);
        }
    }
}
