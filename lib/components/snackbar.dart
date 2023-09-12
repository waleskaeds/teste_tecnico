import 'package:flutter/material.dart';

class SnackBarError {
  static show(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        elevation: 30,
        backgroundColor: Colors.red,
        content: Text("Ocorreu um problema, tente novamente!"),
      )
    );
  }
}

class SnackBarSuccess {
  static show(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        elevation: 30,
        backgroundColor: Colors.green,
        content: Text("Operação realizada com sucesso!"),
      )
    );
  }
}

class SnackBarCart {
  static show(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        elevation: 30,
        backgroundColor: Colors.green,
        content: Text("Produto adicionado ao carrinho!"),
      )
    );
  }
}

class SnackBarRemoveCart {
  static show(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        elevation: 30,
        backgroundColor: Colors.grey,
        content: Text("Produto removido do carrinho!"),
      )
    );
  }
}