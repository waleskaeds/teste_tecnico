import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teste_tecnico/components/cart_info_card.dart';
import 'package:teste_tecnico/components/product_card.dart';
import 'package:teste_tecnico/model/produto.dart';
import 'package:teste_tecnico/providers/product_provider.dart';

class ShopCart extends StatefulWidget {
  const ShopCart({super.key});

  @override
  State<ShopCart> createState() => _ShopCartState();
}

class _ShopCartState extends State<ShopCart> {
  removeCart(Product product){
    Provider.of<ProductProvider>(context, listen: false).removeCart(product, context);
  }
  clearCart(){
    Provider.of<ProductProvider>(context, listen: false).clearCart();
  }
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: const Text(
          "Seu carrinho de compras", 
          style: TextStyle(color: Colors.white)
        ),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: provider.cart.isEmpty
        ? const Center(child: Text("Carrinho limpo."))
        : Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: provider.cart.length,
                itemBuilder: (context, index) {
                  return ProductCard(
                    product: provider.cart[index], 
                    onButtonTapped: () {
                      removeCart(provider.cart[index]);
                    },
                    iconData: Icons.delete_rounded, 
                    buttonColor: Colors.red.withOpacity(0.2)
                  );
                }
              ),
            ),
            CartInfoCard(
              totalPrice: provider.totalCart,
              onButtonTapped: () {
                clearCart();
              }
            ),
          ],
        ),
      ),
    );
  }
}