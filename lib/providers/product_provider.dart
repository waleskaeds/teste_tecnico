// ignore_for_file: prefer_final_fields

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:teste_tecnico/components/snackbar.dart';
import 'package:teste_tecnico/model/produto.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> _products = [
    Product(
      id: 1, 
      nome: 'Camisa Azul', 
      preco: 49.9, 
      material: 'Poliéster', 
      url: "https://malwee.vtexassets.com/arquivos/ids/642858-1200-auto?v=638234727268470000&width=1200&height=auto&aspect=true"
    ),
    Product(
      id: 2, 
      nome: 'Camiseta Cinza', 
      preco: 99.9, 
      material: 'Algodão', 
      url: "https://malwee.vtexassets.com/arquivos/ids/642858-1200-auto?v=638234727268470000&width=1200&height=auto&aspect=true"
    ),
  ];

  List<Product> get products => _products;

  List<Product> cart = [];
  double totalCart = 0;

  double get cartTotalPrice {
   return totalCart;
  }

  Future<void> addCart(Product item) async {
    cart.add(item);
    totalCart += item.preco;
    notifyListeners();
  }

  Future<void> removeCart(Product item, BuildContext context) async {
    cart.remove(item);
    totalCart -= item.preco;
    SnackBarRemoveCart.show(context);
    notifyListeners();
  }

  Future<void> clearCart() async {
    cart.clear();
    notifyListeners();
  }

  Future<void> addProduct(
    BuildContext context,
    Map<String, dynamic> data
  ) async {
    try{
      final item = Product(
        id: Random().nextInt(100), 
        nome: data['nome'], 
        preco: double.parse(data['preco']), 
        material: data['material'], 
        url: data['url']
      );

      _products.add(item);
      notifyListeners();
      SnackBarSuccess.show(context);
    } catch(_){
      SnackBarError.show(context);
    }
  }

  Future<void> editProduct(
    BuildContext context,
    Map<String, dynamic> data
  ) async {
    try{
      final item = Product(
        id: data['id'], 
        nome: data['nome'], 
        preco: double.parse(data['preco']), 
        material: data['material'], 
        url: data['url']
      );

      final index = _products.indexWhere((element) => element.id == item.id);
      _products[index] = item;
      notifyListeners();
      SnackBarSuccess.show(context);
    } catch(_){
      SnackBarError.show(context);
    }
  }

  Future<void> removeProduct(Product product, BuildContext context) async {
    try{
      _products.remove(product);
      removeCart(product, context);
      notifyListeners();
      SnackBarSuccess.show(context);
    } catch (_) {
      SnackBarError.show(context);
    }
  }
}